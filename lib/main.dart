import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  debugPaintSizeEnabled =
      false; // Per veure els layouts. Requereix rendering.dart
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercici. Disseny responsiu i reactiu',
      debugShowCheckedModeBanner: false,
      // Definim el tema de l'aplicacicó. Fem ús de l'esquema de colors Teal
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amberAccent),
      // Widget principal
      home: HomeScreen(),
    );
  }
}
