# Flutter Banking App with MongoDB Integration

A mobile banking application built with Flutter that integrates with a MongoDB database for user authentication, account management, and transaction tracking.

## Features

- **User Authentication**: Secure MPIN-based login system
- **Account Management**: Real-time balance tracking
- **Transaction History**: Complete transaction records
- **Send Money**: Transfer funds to other users
- **MongoDB Integration**: Persistent data storage
- **JWT Authentication**: Secure API communication

## Project Structure

```
flutter_finals/
├── lib/
│   ├── models/          # Data models with JSON serialization
│   ├── services/        # API service for backend communication
│   ├── components/      # Reusable UI components
│   └── *.dart          # Main app screens
├── backend/            # Node.js API server
│   ├── server.js       # Express server with MongoDB
│   ├── package.json    # Backend dependencies
│   └── env.example     # Environment variables template
└── assets/            # Images and fonts
```

## Setup Instructions

### Prerequisites

1. **Flutter SDK** (already installed)
2. **Node.js** (for backend)
3. **MongoDB** (local or cloud)

### 1. Install MongoDB

#### Option A: Local MongoDB
1. Download MongoDB Community Server from [mongodb.com](https://www.mongodb.com/try/download/community)
2. Install and start MongoDB service
3. MongoDB will run on `mongodb://localhost:27017`

#### Option B: MongoDB Atlas (Cloud)
1. Create account at [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free cluster
3. Get your connection string

### 2. Setup Backend

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Create environment file:**
   ```bash
   # Copy the example file
   copy env.example .env
   ```

4. **Edit .env file:**
   ```
   PORT=3000
   MONGODB_URI=mongodb://localhost:27017/flutter_banking
   JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
   ```

5. **Start the backend server:**
   ```bash
   npm start
   # or for development with auto-restart:
   npm run dev
   ```

### 3. Setup Flutter App

1. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate JSON serialization code:**
   ```bash
   flutter packages pub run build_runner build
   ```

3. **Run the app:**
   ```bash
   flutter run -d chrome
   ```

## API Endpoints

### Authentication
- `POST /api/register` - Register new user
- `POST /api/login` - Login user

### User Data
- `GET /api/profile` - Get user profile
- `GET /api/transactions` - Get transaction history
- `PUT /api/balance` - Update balance

### Transactions
- `POST /api/send-money` - Send money to another user

## Database Schema

### User Collection
```javascript
{
  _id: ObjectId,
  phoneNumber: String (unique),
  mpin: String (hashed),
  balance: Number,
  transactions: [{
    type: String (send/receive/cash-in),
    amount: Number,
    recipient: String,
    description: String,
    timestamp: Date
  }],
  createdAt: Date
}
```

## Default Test Account

- **Phone Number**: `092738039355`
- **MPIN**: `2222` (or any 4-digit code for new registration)

## Development Notes

### Adding New Features

1. **Backend**: Add new routes in `backend/server.js`
2. **Models**: Create new models in `lib/models/`
3. **API Service**: Add methods in `lib/services/api_service.dart`
4. **State Management**: Update `lib/account-state.dart`
5. **UI**: Create new screens in `lib/`

### Security Features

- MPIN hashing with bcrypt
- JWT token authentication
- Secure storage for tokens
- Input validation
- Error handling

### Error Handling

The app includes comprehensive error handling:
- Network errors
- Authentication failures
- Invalid input validation
- Database connection issues

## Troubleshooting

### Common Issues

1. **MongoDB Connection Error**
   - Ensure MongoDB is running
   - Check connection string in `.env`
   - Verify network connectivity

2. **Flutter Build Errors**
   - Run `flutter clean`
   - Run `flutter pub get`
   - Regenerate JSON code: `flutter packages pub run build_runner build`

3. **API Connection Issues**
   - Verify backend server is running on port 3000
   - Check CORS settings
   - Ensure proper authentication headers

### Debug Mode

For development, you can enable debug logging by modifying the API service to include console logs for debugging network requests and responses.

## Production Deployment

For production deployment:

1. **Backend**: Deploy to cloud platform (Heroku, AWS, etc.)
2. **Database**: Use MongoDB Atlas or self-hosted MongoDB
3. **Security**: Change JWT secret and enable HTTPS
4. **Environment**: Update API URLs in Flutter app

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.
