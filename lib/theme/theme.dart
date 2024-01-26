// Thème Lumineux Personnalisé

import 'package:flutter/material.dart';

// Thème Material 3 Lumineux Personnalisé
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Couleur principale
    brightness: Brightness.light,
  ),
  // Ajoutez d'autres personnalisations ici
);

// Thème Material 3 Sombre Personnalisé
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Couleur principale
    brightness: Brightness.dark,
  ),
  // Ajoutez d'autres personnalisations ici
);

final firstTHeme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 131, 57, 0),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ));
