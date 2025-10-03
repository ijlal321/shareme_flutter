import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:provider/provider.dart';
import 'providers/websocket_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WebSocketProvider()),
      ],
      child: MyApp(),
    ),
  );
}

