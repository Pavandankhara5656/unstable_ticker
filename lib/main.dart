import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unstable_ticker/providers/stock_provider.dart';
import 'package:unstable_ticker/screens/home_screen.dart';
import 'providers/connection_status_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectionStatusProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unstable Ticker',
        home:  HomeScreen(),
      ),
    );
  }
}
