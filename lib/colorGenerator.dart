import 'package:flutter/material.dart';
import 'package:namer_app/bigCard.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class ColorGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var color = appState.currentColor;

    IconData icon;
    if (appState.favorites.colors.contains(color)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Hex: #" +
                        (color.r * 255)
                            .toInt()
                            .toRadixString(16)
                            .padLeft(2, '0') +
                        (color.g * 255)
                            .toInt()
                            .toRadixString(16)
                            .padLeft(2, '0') +
                        (color.b * 255)
                            .toInt()
                            .toRadixString(16)
                            .padLeft(2, '0')),
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
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleColorFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    appState.getNextColor();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
