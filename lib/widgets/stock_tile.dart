import 'package:flutter/material.dart';
import '../models/stock_model.dart';

class StockTile extends StatelessWidget {
  final StockModel stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.ticker, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        '\$${stock.price.toStringAsFixed(2)}',
        style: TextStyle(
          color: stock.isAnomalous ? Colors.orange : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: stock.isAnomalous
          ? const Icon(Icons.warning, color: Colors.orange)
          : null,
    );
  }
}