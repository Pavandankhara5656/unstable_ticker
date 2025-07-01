import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/stock_model.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _controller = StreamController<List<StockModel>>.broadcast();
  Stream<List<StockModel>> get stream => _controller.stream;

  final _connectionStatusController = StreamController<String>.broadcast();
  Stream<String> get connectionStatusStream => _connectionStatusController.stream;

  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;

  void connect() {
    _connectionStatusController.add('Connecting');
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));

    _connectionStatusController.add('Connected');

    _channel!.stream.listen(
          (data) {
        try {
          final decoded = jsonDecode(data);
          if (decoded is List) {
            final stocks = decoded.map((e) {
              return StockModel(
                ticker: e['ticker'],
                price: double.tryParse(e['price'].toString()) ?? 0,
              );
            }).toList();
            _controller.add(stocks);
          }
        } catch (e) {
          // Ignore malformed data
        }
      },
      onDone: _reconnect,
      onError: (error) => _reconnect(),
      cancelOnError: true,
    );
  }

  void _reconnect() {
    _connectionStatusController.add('Reconnecting');
    _reconnectAttempts++;
    final delay = Duration(seconds: _calculateBackoff(_reconnectAttempts));
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () => connect());
  }

  int _calculateBackoff(int attempt) {
    return attempt >= 5 ? 30 : (1 << attempt); // 2^attempt, capped at 30s
  }

  void dispose() {
    _channel?.sink.close();
    _controller.close();
    _reconnectTimer?.cancel();
    _connectionStatusController.close();
  }
}