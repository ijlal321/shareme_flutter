// services/websocket_service.dart
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<void> connect([String? url]) async {
    try {
      // Use provided URL or default to localhost
      final connectionUrl = url ?? 'ws://localhost:8080';
      
      _channel = WebSocketChannel.connect(Uri.parse(connectionUrl));
      _isConnected = true;
      
      // Listen for connection close
      _channel!.stream.handleError((error) {
        _isConnected = false;
        _channel = null;
      });
      
    } catch (e) {
      _isConnected = false;
      _channel = null;
      rethrow; // Let caller handle the error
    }
  }

  Stream? get stream => _channel?.stream;

  void send(String message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(message);
    } else {
      throw StateError('WebSocket is not connected');
    }
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
      _isConnected = false;
    }
  }

  void dispose() {
    disconnect();
  }
}
