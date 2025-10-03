import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/client.dart';

class DataProvider extends ChangeNotifier {
  final List<Client> _clients = [];

  List<Client> get clients => List.unmodifiable(_clients);

}


/*
  Read Clients
  List<Client> allClients = dataProvider.clients;



*/