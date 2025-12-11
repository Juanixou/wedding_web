import 'package:flutter/material.dart';

/// Paleta de colores centralizada para la web de la boda
/// Basada en burdeos como color principal
class WeddingColors {
  // Colores principales - Burdeos
  static const Color burgundyPrimary = Color(0xFF722F37);
  static const Color burgundyDark = Color(0xFF5A2429);
  static const Color burgundyLight = Color(0xFF8B3D47);
  static const Color burgundyVeryLight = Color(0xFFF5E8EA);

  // Colores de texto
  static Color get textPrimary => burgundyDark;
  static Color get textSecondary => burgundyLight.withOpacity(0.7);
  
  // Colores de fondo
  static Color get backgroundLight => burgundyVeryLight;
  static Color get backgroundWhite => Colors.white;
  
  // Colores de bordes y sombras
  static Color get borderColor => burgundyPrimary.withOpacity(0.3);
  static Color get shadowColor => burgundyPrimary.withOpacity(0.2);
  
  // Colores de botones
  static Color get buttonPrimary => burgundyPrimary;
  static Color get buttonPrimaryHover => burgundyDark;
  
  // Colores de elementos interactivos
  static Color get chipSelected => burgundyVeryLight;
  static Color get inputFocusedBorder => burgundyPrimary;
  static Color get iconColor => burgundyPrimary;
  
  // Colores de feedback
  static Color get successColor => Colors.green.shade700;
  static Color get errorColor => Colors.red.shade700;
}

