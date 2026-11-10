import 'package:flutter/material.dart';

import 'pantallas/pantalla_inicio_sesion.dart';

// Punto de entrada: inicia la aplicación Flutter.
void main() {
  runApp(const AplicacionInstagram());
}

// Configuración general del tema y de la primera pantalla de la aplicación.
class AplicacionInstagram extends StatelessWidget {
  const AplicacionInstagram({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram - Simulación',
      debugShowCheckedModeBanner: false,
      // Tema oscuro compartido por todas las pantallas.
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE1306C),
          brightness: Brightness.dark,
          surface: const Color(0xFF090D12),
        ),
        scaffoldBackgroundColor: const Color(0xFF090D12),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF090D12),
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      // El usuario siempre comienza en el formulario de acceso.
      home: const PantallaInicioSesion(),
    );
  }
}
