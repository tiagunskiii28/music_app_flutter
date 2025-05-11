import 'package:flutter/foundation.dart';

import '../models/artist_data.dart';
import '../models/event_data.dart';
import '../services/api_service.dart';

/// ViewModel para gestionar el estado de los datos de un artista y sus eventos.
class ArtistViewModel extends ChangeNotifier {
  final ApiService apiService;

  bool _isLoading = false;
  ArtistData? _artist;
  List<EventData>? _events;
  String? _errorMessage;

  ArtistViewModel({required this.apiService});

  bool get isLoading => _isLoading;
  ArtistData? get artist => _artist;
  List<EventData>? get events => _events;
  String? get errorMessage => _errorMessage;

  /// Carga la información del artista y sus eventos.
  Future<void> loadArtistData(String artistName, {String? dateFilter}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedArtist = await apiService.fetchArtist(artistName);
      final fetchedEvents = await apiService.fetchEvents(artistName, dateFilter: dateFilter);

      _artist = fetchedArtist;
      _events = fetchedEvents;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Limpia los datos cargados y el estado de error.
  void clear() {
    _artist = null;
    _events = null;
    _errorMessage = null;
    notifyListeners();
  }
}
