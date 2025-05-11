import 'dart:convert';

/// Modelo que representa un juego en la API FreeToGame.
class GameData {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String status;
  final DateTime? releaseDate;

  GameData({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.status,
    this.releaseDate,
  });

  /// Crea una instancia de [GameData] a partir de un [Map] JSON, manejando valores nulos.
  factory GameData.fromJson(Map<String, dynamic> json) {
    // Para evitar excepciones, convertimos todo a String y usamos valores por defecto
    final id = json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '') ?? 0;
    final title = json['title']?.toString() ?? 'Unknown';
    final thumbnail = json['thumbnail']?.toString() ?? '';
    final genre = json['genre']?.toString() ?? 'Unknown';
    final platform = json['platform']?.toString() ?? 'Unknown';
    final status = json['status']?.toString() ?? 'Unknown';

    DateTime? releaseDate;
    final dateString = json['release_date']?.toString();
    if (dateString != null && dateString.isNotEmpty) {
      try {
        releaseDate = DateTime.parse(dateString);
      } catch (_) {
        releaseDate = null;
      }
    }

    return GameData(
      id: id,
      title: title,
      thumbnail: thumbnail,
      genre: genre,
      platform: platform,
      status: status,
      releaseDate: releaseDate,
    );
  }

  /// Convierte la instancia de [GameData] a un [Map] JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'genre': genre,
      'platform': platform,
      'status': status,
      'release_date': releaseDate?.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
