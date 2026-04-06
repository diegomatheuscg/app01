import 'package:app01/telas/Dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Locação de Automóveis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(), filled: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )
          )
        )
      ),
      home: const TelaDashboard(),
    );
  }
}

class Dashboard {}
