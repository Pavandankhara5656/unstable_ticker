import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import 'connection_status_provider.dart';

class StockProvider extends ChangeNotifier {
  final List<StockModel> _stocks = [];
  final Map<String, double> _previousPrices = {};

  List<StockModel> get stocks => List.unmodifiable(_stocks);

  void updateFromStream(ConnectionStatusProvider connectionStatusProvider) {
    final service = connectionStatusProvider.webSocketService;
    service.stream.listen((incomingStocks) {
      _stocks.clear();
      for (final stock in incomingStocks) {
        final previous = _previousPrices[stock.ticker] ?? stock.price;
        final isAnomalous = (previous - stock.price) / previous > 0.5;
        _stocks.add(stock.copyWith(isAnomalous: isAnomalous));
        if (!isAnomalous) {
          _previousPrices[stock.ticker] = stock.price;
        }
      }
      notifyListeners();
    });
  }
}
