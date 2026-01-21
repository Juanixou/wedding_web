// lib/widgets/hero_section_widget.dart

import 'package:flutter/material.dart';

class HeroSectionWidget extends StatelessWidget {
  final String assetImagePath;
  final bool applySepiaFilter;

  const HeroSectionWidget({
    super.key,
    this.assetImagePath = 'assets/hero_image.png',
    this.applySepiaFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculamos la altura basada en el ancho para mantener proporción
        // Usamos una relación de aspecto común para hero sections (16:9 o similar)
        final height = constraints.maxWidth * 0.6; // Ajusta según necesites
        
        return SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo con filtro sepia opcional
              _buildBackgroundImage(),
              
              // Overlay oscuro para mejorar contraste
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
              
              // Contenido centrado sobre la imagen
              _buildCenteredContent(context, constraints.maxWidth),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage() {
    final imageWidget = Image.asset(
      assetImagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade300,
          child: const Center(
            child: Text(
              'Error al cargar la imagen.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );

    if (applySepiaFilter) {
      return ColorFiltered(
        // Filtro sepia usando matriz de color
        colorFilter: const ColorFilter.matrix([
          0.393, 0.769, 0.189, 0, 0, // R
          0.349, 0.686, 0.168, 0, 0, // G
          0.272, 0.534, 0.131, 0, 0, // B
          0,     0,     0,     1, 0, // A
        ]),
        child: imageWidget,
      );
    } else {
      return imageWidget;
    }
  }

  // Función helper para calcular tamaño de fuente responsive
  double _getResponsiveFontSize(double screenWidth, double minSize, double maxSize) {
    // Breakpoints: móvil < 768px, tablet < 1024px, desktop >= 1024px
    if (screenWidth < 768) {
      // Móvil: usar tamaño mínimo
      return minSize;
    } else if (screenWidth < 1024) {
      // Tablet: interpolación entre min y max
      final ratio = (screenWidth - 768) / (1024 - 768);
      return minSize + (maxSize - minSize) * ratio;
    } else {
      // Desktop: usar tamaño máximo
      return maxSize;
    }
  }

  Widget _buildCenteredContent(BuildContext context, double screenWidth) {
    // Calcular tamaños de fuente responsive (reducidos para móvil)
    final dateFontSize = _getResponsiveFontSize(screenWidth, 18.0, 36.0);
    final namesFontSize = _getResponsiveFontSize(screenWidth, 24.0, 48.0);
    final quoteFontSize = _getResponsiveFontSize(screenWidth, 12.0, 20.0);
    final quoteMarkFontSize = _getResponsiveFontSize(screenWidth, 18.0, 32.0);
    
    // Calcular padding responsive (reducido para móvil)
    final horizontalPadding = screenWidth < 768 ? 12.0 : 32.0;
    final verticalPadding = screenWidth < 768 ? 20.0 : 48.0;
    final containerPadding = screenWidth < 768 ? 16.0 : 24.0;
    
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: containerPadding),
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Decoración superior - línea decorativa
              Container(
                width: screenWidth < 768 ? 40 : 60,
                height: 2,
                margin: EdgeInsets.only(bottom: screenWidth < 768 ? 12 : 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Fecha de la boda
              Text(
                '10.10.26',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dateFontSize,
                  fontWeight: FontWeight.w300,
                  letterSpacing: screenWidth < 768 ? 3 : 6,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 2),
                      blurRadius: 12,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenWidth < 768 ? 12 : 28),
              
              // Separador decorativo
              Container(
                width: screenWidth < 768 ? 30 : 40,
                height: 1,
                margin: EdgeInsets.symmetric(vertical: screenWidth < 768 ? 4 : 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              
              SizedBox(height: screenWidth < 768 ? 4 : 8),
              
              // Nombres
              Text(
                'Cristina & Carlos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: namesFontSize,
                  fontWeight: FontWeight.w300,
                  letterSpacing: screenWidth < 768 ? 2 : 4,
                  color: Colors.white,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 3),
                      blurRadius: 15,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenWidth < 768 ? 16 : 32),
              
              // Separador decorativo
              Container(
                width: screenWidth < 768 ? 30 : 40,
                height: 1,
                margin: EdgeInsets.symmetric(vertical: screenWidth < 768 ? 4 : 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              
              SizedBox(height: screenWidth < 768 ? 12 : 24),
              
              // Quote con comillas decorativas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: quoteMarkFontSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.7),
                      height: 0.5,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '¿Sabes contar? Pues contamos contigo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: quoteFontSize,
                        fontWeight: FontWeight.w300,
                        letterSpacing: screenWidth < 768 ? 0.8 : 1.2,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Shadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '"',
                    style: TextStyle(
                      fontSize: quoteMarkFontSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.7),
                      height: 0.5,
                    ),
                  ),
                ],
              ),
              
              // Decoración inferior - línea decorativa
              Container(
                width: screenWidth < 768 ? 40 : 60,
                height: 2,
                margin: EdgeInsets.only(top: screenWidth < 768 ? 12 : 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}