import 'package:flutter/foundation.dart';
import '../services/websocket_service.dart';

class ConnectionStatusProvider extends ChangeNotifier {
  final WebSocketService _webSocketService = WebSocketService();
  String _status = 'Disconnected';

  String get status => _status;
  WebSocketService get webSocketService => _webSocketService;

  ConnectionStatusProvider() {
    _webSocketService.connectionStatusStream.listen((status) {
      _status = status;
      notifyListeners();
    });
    _webSocketService.connect();
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}