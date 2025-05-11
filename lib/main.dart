import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'views/game_list_view.dart';

void main() {
  // Instancia del servicio de API
  final apiService = ApiService();

  runApp(
    MaterialApp(
      title: 'FreeToGame Browser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameListView(apiService: apiService),
    ),
  );
}
