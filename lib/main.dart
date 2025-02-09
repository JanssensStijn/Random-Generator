import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

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
  final List<WordPair> wordpairs = [];
  final List<Color> colors = [];
}

class MyAppState extends ChangeNotifier {
  var currentWordPair = WordPair.random();
  var currentColor = RandomColor.getColorObject(Options());

  void getNextWordPair() {
    currentWordPair = WordPair.random();
    notifyListeners();
  }

  void getNextColor() {
    currentColor = RandomColor.getColorObject(Options());
    notifyListeners();
  }

  var favorites = _Favorites();

  void toggleWordFavorite() {
    if (favorites.wordpairs.contains(currentWordPair)) {
      favorites.wordpairs.remove(currentWordPair);
    } else {
      favorites.wordpairs.add(currentWordPair);
    }
    notifyListeners();
  }

  void toggleColorFavorite() {
    if (favorites.colors.contains(currentColor)) {
      favorites.colors.remove(currentColor);
    } else {
      favorites.colors.add(currentColor);
    }
    notifyListeners();
  }
  void removeWordPairFavorite(WordPair pair) {
    favorites.wordpairs.remove(pair);
    notifyListeners();
  }

  void removeColorFavorite(Color color) {
    favorites.colors.remove(color);
    notifyListeners();
  }
}