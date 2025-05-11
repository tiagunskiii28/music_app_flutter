import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/game_data.dart';

/// Servicio para conectar con la API de FreeToGame y obtener juegos.
class ApiService {
  static const _baseUrl = 'https://www.freetogame.com/api';

  /// Obtiene la lista completa de juegos.
  Future<List<GameData>> fetchGames() async {
    final url = Uri.parse('$_baseUrl/games');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error al cargar juegos: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    late final List<dynamic> jsonList;

    // Maneja tanto un array JSON directo como un objeto con clave 'games'
    if (decoded is List) {
      jsonList = decoded;
    } else if (decoded is Map<String, dynamic> && decoded.containsKey('games')) {
      jsonList = decoded['games'] as List<dynamic>;
    } else {
      throw Exception('Formato de JSON inesperado');
    }

    return jsonList
        .map((item) => GameData.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}