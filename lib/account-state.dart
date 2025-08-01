import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/user.dart';

/// AccountState manages the user's account balance and notifies listeners on changes.
class AccountState extends ChangeNotifier {
  double _balance = 0.0;
  User? _currentUser;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  AccountState() {
    // Don't load user data immediately - wait for login
    // _loadUserData();
  }

  double get balance => _balance;
  User? get currentUser => _currentUser;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Updates the balance and notifies listeners.
  set balance(double value) {
    _balance = value;
    notifyListeners();
  }

  /// Load user data from API
  Future<void> _loadUserData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final user = await ApiService.getProfile();
      _currentUser = user;
      _balance = user.balance;
      _transactions = user.transactions;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login user
  Future<bool> login(String phoneNumber, String mpin) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await ApiService.login(phoneNumber, mpin);
      _currentUser = User(
        id: result['user']['id'],
        phoneNumber: result['user']['phoneNumber'],
        balance: result['user']['balance'].toDouble(),
        transactions: [],
        createdAt: DateTime.now(),
      );
      _balance = _currentUser!.balance;
      
      // Load full user data
      await _loadUserData();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Register user
  Future<bool> register(String phoneNumber, String mpin) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await ApiService.register(phoneNumber, mpin);
      _currentUser = User(
        id: result['user']['id'],
        phoneNumber: result['user']['phoneNumber'],
        balance: result['user']['balance'].toDouble(),
        transactions: [],
        createdAt: DateTime.now(),
      );
      _balance = _currentUser!.balance;
      
      // Load full user data
      await _loadUserData();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Send money
  Future<bool> sendMoney(String recipient, double amount, String description) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await ApiService.sendMoney(recipient, amount, description);
      _balance = result['newBalance'];
      
      // Reload transactions
      await _loadUserData();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Update balance
  Future<bool> updateBalance(double newBalance) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updatedBalance = await ApiService.updateBalance(newBalance);
      _balance = updatedBalance;
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    await ApiService.logout();
    _currentUser = null;
    _balance = 0.0;
    _transactions = [];
    _error = null;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Refresh user data
  Future<void> refresh() async {
    await _loadUserData();
  }
}

/// To watch balance use: context.watch<AccountState>().balance
/// To read/update balance use: context.read<AccountState>().balance
