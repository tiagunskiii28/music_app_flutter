import 'dart:convert';

/// Modelo que representa los datos de un artista obtenidos de la API Bandsintown.
class ArtistData {
  final int? id;
  final String name;
  final String url;
  final String imageUrl;
  final String thumbUrl;
  final String facebookPageUrl;
  final String mbid;
  final int trackerCount;
  final int upcomingEventCount;

  ArtistData({
    this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
    required this.thumbUrl,
    required this.facebookPageUrl,
    required this.mbid,
    required this.trackerCount,
    required this.upcomingEventCount,
  });

  /// Crea una instancia de [ArtistData] a partir de un [Map] JSON.
  factory ArtistData.fromJson(Map<String, dynamic> json) {
    return ArtistData(
      id: json['id'] as int?,
      name: json['name'] as String,
      url: json['url'] as String,
      imageUrl: json['image_url'] as String,
      thumbUrl: json['thumb_url'] as String,
      facebookPageUrl: json['facebook_page_url'] as String,
      mbid: json['mbid'] as String,
      trackerCount: json['tracker_count'] as int,
      upcomingEventCount: json['upcoming_event_count'] as int,
    );
  }

  /// Convierte la instancia de [ArtistData] a un [Map] JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'image_url': imageUrl,
      'thumb_url': thumbUrl,
      'facebook_page_url': facebookPageUrl,
      'mbid': mbid,
      'tracker_count': trackerCount,
      'upcoming_event_count': upcomingEventCount,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
