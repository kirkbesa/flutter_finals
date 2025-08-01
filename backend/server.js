const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors({
  origin: true, // Allow all origins
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());

// Serve static files from parent directory
app.use(express.static('../'));

// MongoDB Connection
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/flutter_banking', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

// User Schema
const userSchema = new mongoose.Schema({
  phoneNumber: { type: String, required: true, unique: true },
  mpin: { type: String, required: true },
  balance: { type: Number, default: 15000.00 },
  transactions: [{
    type: { type: String, enum: ['send', 'receive', 'cash-in'], required: true },
    amount: { type: Number, required: true },
    recipient: { type: String },
    description: { type: String },
    timestamp: { type: Date, default: Date.now }
  }],
  createdAt: { type: Date, default: Date.now }
});

const User = mongoose.model('User', userSchema);

// Routes

// Register new user
app.post('/api/register', async (req, res) => {
  try {
    const { phoneNumber, mpin } = req.body;
    
    // Check if user already exists
    const existingUser = await User.findOne({ phoneNumber });
    if (existingUser) {
      return res.status(400).json({ error: 'User already exists' });
    }

    // Hash MPIN
    const hashedMpin = await bcrypt.hash(mpin, 10);

    // Create new user
    const user = new User({
      phoneNumber,
      mpin: hashedMpin,
      balance: 15000.00
    });

    await user.save();

    // Generate JWT token
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET || 'your-secret-key', { expiresIn: '24h' });

    res.status(201).json({
      message: 'User registered successfully',
      token,
      user: {
        id: user._id,
        phoneNumber: user.phoneNumber,
        balance: user.balance
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// Login user
app.post('/api/login', async (req, res) => {
  try {
    const { phoneNumber, mpin } = req.body;

    // Find user
    const user = await User.findOne({ phoneNumber });
    if (!user) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    // Check MPIN
    const isValidMpin = await bcrypt.compare(mpin, user.mpin);
    if (!isValidMpin) {
      return res.status(400).json({ error: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET || 'your-secret-key', { expiresIn: '24h' });

    res.json({
      message: 'Login successful',
      token,
      user: {
        id: user._id,
        phoneNumber: user.phoneNumber,
        balance: user.balance
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// Get user profile
app.get('/api/profile', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const user = await User.findById(decoded.userId).select('-mpin');
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({ user });
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
});

// Get user transactions
app.get('/api/transactions', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const user = await User.findById(decoded.userId);
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({ transactions: user.transactions });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// Send money
app.post('/api/send-money', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const { recipient, amount, description } = req.body;

    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    if (user.balance < amount) {
      return res.status(400).json({ error: 'Insufficient balance' });
    }

    // Update sender's balance and add transaction
    user.balance -= amount;
    user.transactions.push({
      type: 'send',
      amount: -amount,
      recipient,
      description,
      timestamp: new Date()
    });

    await user.save();

    res.json({
      message: 'Money sent successfully',
      newBalance: user.balance,
      transaction: user.transactions[user.transactions.length - 1]
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// Update balance
app.put('/api/balance', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const { balance } = req.body;

    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    user.balance = balance;
    await user.save();

    res.json({
      message: 'Balance updated successfully',
      balance: user.balance
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// Change MPIN
app.put('/api/change-mpin', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const { currentMpin, newMpin } = req.body;

    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Verify current MPIN
    const isValidCurrentMpin = await bcrypt.compare(currentMpin, user.mpin);
    if (!isValidCurrentMpin) {
      return res.status(400).json({ error: 'Current MPIN is incorrect' });
    }

    // Hash new MPIN
    const hashedNewMpin = await bcrypt.hash(newMpin, 10);
    user.mpin = hashedNewMpin;
    await user.save();

    res.json({
      message: 'MPIN changed successfully'
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 