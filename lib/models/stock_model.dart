class StockModel {
  final String ticker;
  final double price;
  final bool isAnomalous;

  StockModel({
    required this.ticker,
    required this.price,
    this.isAnomalous = false,
  });

  StockModel copyWith({
    double? price,
    bool? isAnomalous,
  }) {
    return StockModel(
      ticker: ticker,
      price: price ?? this.price,
      isAnomalous: isAnomalous ?? this.isAnomalous,
    );
  }
}