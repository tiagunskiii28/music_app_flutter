import 'package:flutter/foundation.dart';

import '../models/event_data.dart';
import '../services/api_service.dart';

/// ViewModel para gestionar el estado de la lista de eventos de un artista.
class EventViewModel extends ChangeNotifier {
  final ApiService apiService;

  bool _isLoading = false;
  List<EventData>? _events;
  String? _errorMessage;

  EventViewModel({required this.apiService});

  bool get isLoading => _isLoading;
  List<EventData>? get events => _events;
  String? get errorMessage => _errorMessage;

  /// Carga los eventos para [artistName] con filtro de fecha opcional.
  Future<void> loadEvents(String artistName, {String? dateFilter}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _events = await apiService.fetchEvents(artistName, dateFilter: dateFilter);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Limpia el listado de eventos y el estado de error.
  void clear() {
    _events = null;
    _errorMessage = null;
    notifyListeners();
  }
}
