import 'package:flutter/foundation.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';

class CardProvider extends ChangeNotifier {
  List<CreditCard> _cards = [];
  List<Transaction> _transactions = [];

  List<CreditCard> get cards => _cards;
  List<Transaction> get transactions => _transactions;

  void addCard(CreditCard card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeCard(String cardId) {
    _cards.removeWhere((card) => card.id == cardId);
    _transactions.removeWhere((transaction) => transaction.cardId == cardId);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    
    final cardIndex = _cards.indexWhere((card) => card.id == transaction.cardId);
    if (cardIndex != -1) {
      final card = _cards[cardIndex];
      final updatedCard = CreditCard(
        id: card.id,
        cardNumber: card.cardNumber,
        cardHolderName: card.cardHolderName,
        expiryDate: card.expiryDate,
        cvv: card.cvv,
        cardType: card.cardType,
        balance: card.balance + transaction.amount,
        creditLimit: card.creditLimit,
      );
      _cards[cardIndex] = updatedCard;
    }
    
    notifyListeners();
  }

  List<Transaction> getCardTransactions(String cardId) {
    return _transactions.where((t) => t.cardId == cardId).toList();
  }

  double getTotalBalance() {
    return _cards.fold(0, (sum, card) => sum + card.balance);
  }

  double getTotalCreditLimit() {
    return _cards.fold(0, (sum, card) => sum + card.creditLimit);
  }

  double getTotalAvailableCredit() {
    return _cards.fold(0, (sum, card) => sum + card.availableCredit);
  }
}