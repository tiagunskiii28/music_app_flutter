/// Modelo que representa el lugar (venue) de un evento en la API Bandsintown.
class VenueData {
  final String name;
  final double latitude;
  final double longitude;
  final String city;
  final String region;
  final String country;

  VenueData({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.region,
    required this.country,
  });

  /// Crea una instancia de [VenueData] a partir de un [Map] JSON.
  factory VenueData.fromJson(Map<String, dynamic> json) {
    return VenueData(
      name: json['name'] as String,
      latitude: double.parse(json['latitude'] as String),
      longitude: double.parse(json['longitude'] as String),
      city: json['city'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
    );
  }

  /// Convierte la instancia de [VenueData] a un [Map] JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'city': city,
      'region': region,
      'country': country,
    };
  }
}