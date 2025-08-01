import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String phoneNumber;
  final double balance;
  final List<Transaction> transactions;
  final DateTime createdAt;

  User({
    required this.id,
    required this.phoneNumber,
    required this.balance,
    required this.transactions,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Transaction {
  final String id;
  final String type;
  final double amount;
  final String? recipient;
  final String? description;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    this.recipient,
    this.description,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String phoneNumber;
  final String mpin;

  LoginRequest({
    required this.phoneNumber,
    required this.mpin,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String phoneNumber;
  final String mpin;

  RegisterRequest({
    required this.phoneNumber,
    required this.mpin,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class SendMoneyRequest {
  final String recipient;
  final double amount;
  final String description;

  SendMoneyRequest({
    required this.recipient,
    required this.amount,
    required this.description,
  });

  factory SendMoneyRequest.fromJson(Map<String, dynamic> json) => _$SendMoneyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMoneyRequestToJson(this);
} 