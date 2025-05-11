import 'package:flutter/foundation.dart';

import '../models/game_data.dart';
import '../services/api_service.dart';

/// ViewModel para gestionar la lista de juegos, filtrado y estados de carga/error.
class GameViewModel extends ChangeNotifier {
  final ApiService apiService;

  bool _isLoading = false;
  List<GameData> _allGames = [];
  String _filter = '';
  String? _errorMessage;

  GameViewModel({required this.apiService});

  bool get isLoading => _isLoading;
  String get filter => _filter;
  String? get errorMessage => _errorMessage;

  /// Lista de juegos filtrada según [_filter]
  List<GameData> get games {
    if (_filter.isEmpty) {
      return _allGames;
    }
    final query = _filter.toLowerCase();
    return _allGames.where((game) {
      return game.title.toLowerCase().contains(query) ||
          game.genre.toLowerCase().contains(query) ||
          game.platform.toLowerCase().contains(query);
    }).toList();
  }

  /// Carga todos los juegos desde la API.
  Future<void> fetchGames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allGames = await apiService.fetchGames();
    } catch (e) {
      _errorMessage = 'Error al cargar juegos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Actualiza el filtro de búsqueda y notifica para actualizar la vista.
  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  /// Limpia los datos y estado de error.
  void clear() {
    _allGames = [];
    _filter = '';
    _errorMessage = null;
    notifyListeners();
  }
}
