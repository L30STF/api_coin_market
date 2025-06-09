import 'package:flutter/material.dart';

class Crypto {
  final String name;
  final String symbol;
  final String date_added;
  final double price;

  Crypto({
    required this.name,
    required this.symbol,
    required this.date_added,
    required this.price,
  });


  static Crypto fromMap(Map<String, dynamic> CoinMap) {
      double priceValue = 0.0;

  try {
    final quote = CoinMap['quote'];
    if (quote != null && quote['USD'] != null && quote['USD']['price'] != null) {
      priceValue = (quote['USD']['price'] as num).toDouble();
    }
  } catch (e) {
    print('Erro ao ler price: $e');
  }
    
    return Crypto(
      name: CoinMap['name'],
      symbol: CoinMap['symbol'],
      date_added: CoinMap['date_added'],
      price: priceValue,
    );
  }
}