import 'package:flutter/material.dart';
import 'package:wedding_web/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp define el diseño y las rutas de tu aplicación Flutter.
    return MaterialApp(
      title: 'Boda Cris & Carlos', // Título que aparece en la pestaña del navegador
      debugShowCheckedModeBanner: false, // Oculta la etiqueta "Debug" en la esquina
      theme: ThemeData(
        primaryColor: Colors.grey.shade900,
        colorScheme: ColorScheme.light(
          primary: Colors.grey.shade900,
          secondary: Colors.grey.shade700,
          surface: Colors.white,
          background: Colors.white,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),

      home: HomeScreen(),

      // Como es una web de una sola página, no necesitarás rutas complejas.
      // Si usaras rutas (ej. /gallery, /rsvp), usarías la propiedad 'routes' o 'initialRoute'.
    );
  }
}
