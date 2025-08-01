import 'package:flutter/material.dart';

/// AccountState manages the user's account balance and notifies listeners on changes.
class AccountState extends ChangeNotifier {
  double _balance;

  AccountState({double initialBalance = 0.0}) : _balance = initialBalance;

  double get balance => _balance;

  /// Updates the balance and notifies listeners.
  set balance(double value) {
    _balance = value;
    notifyListeners();
  }
}

/// To watch balance use: context.watch<AccountState>().balance
/// To read/update balance use: context.read<AccountState>().balance