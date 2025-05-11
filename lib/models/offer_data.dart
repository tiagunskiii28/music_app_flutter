import 'dart:convert';

/// Modelo que representa una oferta de entradas para un evento en la API Bandsintown.
class OfferData {
  final String type;
  final String url;
  final String status;

  OfferData({
    required this.type,
    required this.url,
    required this.status,
  });

  /// Crea una instancia de [OfferData] a partir de un [Map] JSON.
  factory OfferData.fromJson(Map<String, dynamic> json) {
    return OfferData(
      type: json['type'] as String,
      url: json['url'] as String,
      status: json['status'] as String,
    );
  }

  /// Convierte la instancia de [OfferData] a un [Map] JSON.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      'status': status,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
