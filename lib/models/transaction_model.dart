import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String cardId;
  final String merchant;
  final double amount;
  final DateTime date;
  final String category;
  final bool isReward;
  final String icon;

  Transaction({
    required this.id,
    required this.cardId,
    required this.merchant,
    required this.amount,
    required this.date,
    required this.category,
    this.isReward = false,
    this.icon = '🛒',
  });

  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(date);
  }

  String get formattedAmount {
    return '₹${amount.toStringAsFixed(2)}';
  }
}