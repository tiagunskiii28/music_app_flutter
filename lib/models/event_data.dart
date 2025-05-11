import 'dart:convert';

import 'venue_data.dart';
import 'offer_data.dart';

/// Modelo que representa los datos de un evento obtenido de la API Bandsintown.
class EventData {
  final String id;
  final String artistId;
  final String url;
  final DateTime onSaleDatetime;
  final DateTime datetime;
  final String? description;
  final VenueData venue;
  final List<OfferData> offers;
  final List<String> lineup;

  EventData({
    required this.id,
    required this.artistId,
    required this.url,
    required this.onSaleDatetime,
    required this.datetime,
    this.description,
    required this.venue,
    required this.offers,
    required this.lineup,
  });

  /// Crea una instancia de [EventData] a partir de un [Map] JSON.
  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'] as String,
      artistId: json['artist_id'] as String,
      url: json['url'] as String,
      onSaleDatetime: DateTime.parse(json['on_sale_datetime'] as String),
      datetime: DateTime.parse(json['datetime'] as String),
      description: json['description'] as String?,
      venue: VenueData.fromJson(json['venue'] as Map<String, dynamic>),
      offers: (json['offers'] as List<dynamic>)
          .map((o) => OfferData.fromJson(o as Map<String, dynamic>))
          .toList(),
      lineup:
      (json['lineup'] as List<dynamic>).map((s) => s as String).toList(),
    );
  }

  /// Convierte la instancia de [EventData] a un [Map] JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artist_id': artistId,
      'url': url,
      'on_sale_datetime': onSaleDatetime.toIso8601String(),
      'datetime': datetime.toIso8601String(),
      'description': description,
      'venue': venue.toJson(),
      'offers': offers.map((o) => o.toJson()).toList(),
      'lineup': lineup,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
