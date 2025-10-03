// providers/websocket_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/websocket_service.dart';

class WebSocketProvider with ChangeNotifier {
  final WebSocketService _service = WebSocketService();
  List<String> _messages = [];
  String? _error;

  List<String> get messages => _messages;
  String? get error => _error;
  bool get isConnected => _service.isConnected;

  Future<void> connect([String? url]) async {
    try {
      _error = null;
      await _service.connect(url);
      
      // Listen to the stream after successful connection
      _service.stream?.listen(
        (data) {
          final json = jsonDecode(data);
          final opcode = json['opcode'];
          final payload = json['data'];
          debugPrint('ws_message received: opcode -> $opcode');
          handleWsIncomingMessage(opcode, payload);
          notifyListeners();
        },
        onError: (error) {
          _error = error.toString();
          notifyListeners();
        },
        onDone: () {
          // Connection closed
          notifyListeners();
        },
      );
      
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void sendMessage(String msg) {
    try {
      _service.send(msg);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void disconnect() {
    _service.disconnect();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  void handleWsIncomingMessage(int opcode, dynamic payload){
    
  }

}
