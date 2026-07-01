import 'dart:async';
import 'dart:math';
import 'package:uuid/uuid.dart';

enum PaymentStatus { idle, processing, success, failed }

class PaymentResult {
  final bool success;
  final String transactionId;
  final String message;
  final DateTime timestamp;
  final double amount;

  PaymentResult({
    required this.success,
    required this.transactionId,
    required this.message,
    required this.timestamp,
    required this.amount,
  });
}

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  final _uuid = const Uuid();
  final _random = Random();

  final List<PaymentResult> _transactions = [];
  List<PaymentResult> get transactions => List.unmodifiable(_transactions);

  Future<PaymentResult> processDonation({
    required double amount,
    required String cardNumber,
    required String expiry,
    required String cvv,
    required String cardHolder,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final success = _random.nextDouble() > 0.10;
    final txnId = 'TXN-${_uuid.v4().substring(0, 8).toUpperCase()}';

    final result = PaymentResult(
      success: success,
      transactionId: txnId,
      message: success
          ? 'Donation of Rs. ${amount.toStringAsFixed(0)} processed successfully.'
          : 'Card declined. Please check your card details and try again.',
      timestamp: DateTime.now(),
      amount: amount,
    );

    if (success) _transactions.add(result);
    return result;
  }

  Future<PaymentResult> processSubscription({
    required String planName,
    required double amount,
    required String cardNumber,
    required String expiry,
    required String cvv,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final success = _random.nextDouble() > 0.10;
    final txnId = 'SUB-${_uuid.v4().substring(0, 8).toUpperCase()}';

    final result = PaymentResult(
      success: success,
      transactionId: txnId,
      message: success
          ? '$planName subscription activated successfully.'
          : 'Subscription failed. Please try again.',
      timestamp: DateTime.now(),
      amount: amount,
    );

    if (success) _transactions.add(result);
    return result;
  }
}
