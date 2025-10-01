import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final List<Client> _clients = [];

  List<Client> get clients => List.unmodifiable(_clients);

  void setClients(List<Client> newClients) {
    _clients
      ..clear()
      ..addAll(newClients);
    notifyListeners();
  }

  Client? getClientById(String publicId) {
    return _clients.firstWhere(
      (client) => client.publicId == publicId,
      orElse: () => null,
    );
  }

  void addClient(Client client) {
    _clients.add(client);
    notifyListeners();
  }

  void removeClientById(String publicId) {
    _clients.removeWhere((client) => client.publicId == publicId);
    notifyListeners();
  }

  void updateClient(Client updatedClient) {
    final index = _clients.indexWhere((c) => c.publicId == updatedClient.publicId);
    if (index != -1) {
      _clients[index] = updatedClient;
      notifyListeners();
    }
  }
}


/*
  Read Clients
  List<Client> allClients = dataProvider.clients;



*/