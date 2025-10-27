import 'package:flutter/material.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // NOUVEL IMPORT
import 'package:olinom/screens/welcome.dart'; // Ligne commentée car non utilisée

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Olinom Campus",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Manrope",
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(
                  0xFFB0BCD1)), // Customize the font using Google Fonts
        ),
        // AJOUT DES DÉLÉGUÉS ET DES LOCALES SUPPORTÉES
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', 'FR'), // Support pour le français
        ],
        home: const HomeScreen(
          currentindex: 0,
        ));
  }
}
