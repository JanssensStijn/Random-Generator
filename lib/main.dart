import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
  SemanticsBinding.instance.ensureSemantics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class _Favorites {
  List<WordPair> wordpairs = [];
  List<Color> colors = [];
}

class MyAppState extends ChangeNotifier {
  var currentWordPair = WordPair.random();
  var currentColor = RandomColor.getColorObject(Options());
  var favorites = _Favorites();

  MyAppState() {
    _loadFavorites();
  }

  void getNextWordPair() {
    currentWordPair = WordPair.random();
    notifyListeners();
  }

  void getNextColor() {
    currentColor = RandomColor.getColorObject(Options());
    notifyListeners();
  }

  void toggleWordFavorite() {
    if (favorites.wordpairs.contains(currentWordPair)) {
      favorites.wordpairs.remove(currentWordPair);
    } else {
      favorites.wordpairs.add(currentWordPair);
    }
    _saveFavorites();
    notifyListeners();
  }

  void toggleColorFavorite() {
    if (favorites.colors.contains(currentColor)) {
      favorites.colors.remove(currentColor);
    } else {
      favorites.colors.add(currentColor);
    }
    _saveFavorites();
    notifyListeners();
  }

  void removeWordPairFavorite(WordPair pair) {
    favorites.wordpairs.remove(pair);
    _saveFavorites();
    notifyListeners();
  }

  void removeColorFavorite(Color color) {
    favorites.colors.remove(color);
    _saveFavorites();
    notifyListeners();
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'wordpairs',
        jsonEncode(favorites.wordpairs
            .map((wp) => {'first': wp.first, 'second': wp.second})
            .toList()));
    prefs.setString('colors',
        jsonEncode(favorites.colors.map((color) => color.value).toList()));
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final wordpairsString = prefs.getString('wordpairs');
    final colorsString = prefs.getString('colors');

    if (wordpairsString != null) {
      final wordpairsList = jsonDecode(wordpairsString) as List;
      favorites.wordpairs = wordpairsList.map((wp) {
        return WordPair(wp['first'], wp['second']);
      }).toList();
    }

    if (colorsString != null) {
      final colorsList = jsonDecode(colorsString) as List;
      favorites.colors =
          colorsList.map((colorValue) => Color(colorValue)).toList();
    }

    notifyListeners();
  }
}
