class CreditCard {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String cardType;
  final double balance;
  final double creditLimit;

  CreditCard({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.balance,
    required this.creditLimit,
  });

  String get maskedCardNumber {
    return '**** **** **** ' + cardNumber.substring(cardNumber.length - 4);
  }

  double get availableCredit {
    return creditLimit - balance;
  }

  double get usagePercentage {
    return (balance / creditLimit) * 100;
  }
}