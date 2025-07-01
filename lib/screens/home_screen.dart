import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stock_provider.dart';
import '../providers/connection_status_provider.dart';
import '../widgets/stock_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final stockProvider = Provider.of<StockProvider>(context, listen: false);
    final connProvider = Provider.of<ConnectionStatusProvider>(context, listen: false);
    stockProvider.updateFromStream(connProvider);
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = context.watch<ConnectionStatusProvider>().status;
    final stocks = context.watch<StockProvider>().stocks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unstable Ticker'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(label: Text(connectionStatus)),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) => StockTile(stock: stocks[index]),
      ),
    );
  }
}
