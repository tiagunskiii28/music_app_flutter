import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/artist_data.dart';
import '../models/event_data.dart';

/// Servicio para conectar con la API de Bandsintown.
class ApiService {
  static const _baseUrl = 'https://rest.bandsintown.com';

  final String appId;

  ApiService({required this.appId});

  /// Obtiene la información de un artista por [artistName].
  Future<ArtistData> fetchArtist(String artistName) async {
    final url = Uri.parse('$_baseUrl/artists/$artistName')
        .replace(queryParameters: {'app_id': appId});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ArtistData.fromJson(json);
    } else {
      throw Exception('Error al cargar artista: ${response.statusCode}');
    }
  }

  /// Obtiene los eventos de un artista: "upcoming", "past", "all" o rango de fechas.
  Future<List<EventData>> fetchEvents(
      String artistName, {
        String? dateFilter,
      }) async {
    final params = {'app_id': appId};
    if (dateFilter != null) params['date'] = dateFilter;
    final url = Uri.parse('$_baseUrl/artists/$artistName/events')
        .replace(queryParameters: params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((e) => EventData.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar eventos: ${response.statusCode}');
    }
  }
}
