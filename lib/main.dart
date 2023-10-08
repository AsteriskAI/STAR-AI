import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(isDense: true),
        useMaterial3: true,
        fontFamily: 'Mozart',
      ),
      home: const HomePage(),
    );
  }
}
