import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/game_view_model.dart';
import '../services/api_service.dart';
import '../models/game_data.dart';

class GameListView extends StatefulWidget {
  final ApiService apiService;

  const GameListView({Key? key, required this.apiService}) : super(key: key);

  @override
  _GameListPageState createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListView> {
  late GameViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GameViewModel(apiService: widget.apiService);
    _viewModel.fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FreeToGame List'),
        ),
        body: Consumer<GameViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (vm.errorMessage != null) {
              return Center(
                child: Text(vm.errorMessage!),
              );
            }
            final games = vm.games;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar juegos',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: vm.setFilter,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final GameData game = games[index];
                      return ListTile(
                        leading: Image.network(
                          game.thumbnail,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(game.title),
                        subtitle: Text('${game.genre} • ${game.platform}'),
                        onTap: () => _showGameDetails(context, game),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showGameDetails(BuildContext context, GameData game) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(game.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Género: ${game.genre}'),
            Text('Plataforma: ${game.platform}'),
            Text('Estado: ${game.status}'),
            Text('Fecha de lanzamiento: ${game.releaseDate != null ? game.releaseDate!.toLocal() : 'Desconocida'}'),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
