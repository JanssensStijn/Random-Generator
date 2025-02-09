
import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    if (favorites.wordpairs.isEmpty && favorites.colors.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        if (favorites.wordpairs.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('No favorite wordpairs yet.'),
            ),
          )
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('You have '
                  '${appState.favorites.wordpairs.length} favorite wordpairs:'),
            ),
          ),
        ...favorites.wordpairs.map(
          (pair) => ListTile(
            leading: IconButton(
              icon: Icon(Icons.favorite, size: 40),
              onPressed: () {
                appState.removeWordPairFavorite(pair);
              },
            ),
            title: Text(pair.asLowerCase),
          ),
        ),
        if (favorites.colors.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('No favorite colors yet.'),
            ),
          )
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('You have '
                  '${appState.favorites.colors.length} favorite colors:'),
            ),
          ),
        ...favorites.colors.map(
          (color) => ListTile(
            leading: IconButton(
              icon: Icon(Icons.favorite, color: color, size: 40),
              onPressed: () {
                appState.removeColorFavorite(color);
              },
            ),
            title: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Hex: #" +
                    (color.r * 255).toInt().toRadixString(16).padLeft(2, '0') +
                    (color.g * 255).toInt().toRadixString(16).padLeft(2, '0') +
                    (color.b * 255).toInt().toRadixString(16).padLeft(2, '0')),
                Text("RGB: " +
                    (color.r * 255).toString() +
                    ", " +
                    (color.g * 255).toString() +
                    ", " +
                    (color.b * 255).toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
