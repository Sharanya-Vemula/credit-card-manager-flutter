import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../providers/card_provider.dart';
import '../utils/colors.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _creditLimitController = TextEditingController();
  String _selectedCardType = 'Visa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: const InputDecoration(labelText: 'Card Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card)),
                validator: (v) => v == null || v.length != 16 ? 'Enter valid 16-digit card number' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _cardHolderController,
                decoration: const InputDecoration(labelText: 'Card Holder Name', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (v) => v == null || v.isEmpty ? 'Enter card holder name' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      maxLength: 5,
                      decoration: const InputDecoration(labelText: 'Expiry (MM/YY)', border: OutlineInputBorder()),
                      validator: (v) => v == null || !v.contains('/') ? 'Enter valid expiry' : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      maxLength: 3,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'CVV', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.length != 3 ? 'Enter valid CVV' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _creditLimitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Credit Limit', border: OutlineInputBorder(), prefixText: '₹'),
                validator: (v) => v == null || double.tryParse(v) == null ? 'Enter valid limit' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<CardProvider>(context, listen: false).addCard(CreditCard(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        cardNumber: _cardNumberController.text,
                        cardHolderName: _cardHolderController.text,
                        expiryDate: _expiryController.text,
                        cvv: _cvvController.text,
                        cardType: _selectedCardType,
                        balance: 0,
                        creditLimit: double.parse(_creditLimitController.text),
                      ));
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, foregroundColor: Colors.white),
                  child: const Text('Add Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}