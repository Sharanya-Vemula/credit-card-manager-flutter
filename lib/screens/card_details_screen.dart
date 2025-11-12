import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../providers/card_provider.dart';
import '../widgets/transaction_item.dart';
import '../utils/colors.dart';

class CardDetailsScreen extends StatelessWidget {
  final CreditCard card;

  const CardDetailsScreen({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Card'),
                  content: const Text('Are you sure?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Provider.of<CardProvider>(context, listen: false).removeCard(card.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<CardProvider>(
        builder: (context, cardProvider, child) {
          final transactions = cardProvider.getCardTransactions(card.id);
          
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.cardType.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      Text(card.maskedCardNumber, style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 2.5)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Card Holder', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text(card.cardHolderName, style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Expires', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text(card.expiryDate, style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          cardProvider.addTransaction(Transaction(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            cardId: card.id,
                            merchant: 'Amazon',
                            amount: 1299.00,
                            date: DateTime.now(),
                            category: 'Shopping',
                          ));
                        },
                        child: const Text('+ Add Sample Transaction'),
                      ),
                    ],
                  ),
                ),
                transactions.isEmpty
                    ? const Padding(padding: EdgeInsets.all(32), child: Text('No transactions yet'))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) => TransactionItem(transaction: transactions[index]),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}