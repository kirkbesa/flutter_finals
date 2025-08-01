// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  phoneNumber: json['phoneNumber'] as String,
  balance: (json['balance'] as num).toDouble(),
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'balance': instance.balance,
  'transactions': instance.transactions,
  'createdAt': instance.createdAt.toIso8601String(),
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String?,
  type: json['type'] as String,
  amount: (json['amount'] as num).toDouble(),
  recipient: json['recipient'] as String?,
  description: json['description'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'recipient': instance.recipient,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  phoneNumber: json['phoneNumber'] as String,
  mpin: json['mpin'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'mpin': instance.mpin,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      phoneNumber: json['phoneNumber'] as String,
      mpin: json['mpin'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'mpin': instance.mpin,
    };

SendMoneyRequest _$SendMoneyRequestFromJson(Map<String, dynamic> json) =>
    SendMoneyRequest(
      recipient: json['recipient'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$SendMoneyRequestToJson(SendMoneyRequest instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'amount': instance.amount,
      'description': instance.description,
    };
