import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HotelsSection extends StatefulWidget {
  const HotelsSection({super.key});

  @override
  State<HotelsSection> createState() => _HotelsSectionState();
}

class _HotelsSectionState extends State<HotelsSection> {
  late ScrollController _scrollController;
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollButtons);
    // Verificar el estado inicial después de que el widget se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollButtons();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtons);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;
    
    final position = _scrollController.position;
    final canScrollLeft = position.pixels > 0;
    final canScrollRight = position.pixels < position.maxScrollExtent;
    
    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Procesa la URL de imagen para asegurar que sea una URL directa
  /// Si es una URL de Google Images, intenta extraer la URL directa de la imagen
  static String _processImageUrl(String url) {
    // Si la URL contiene parámetros de Google Images, intentar limpiarla
    // Las URLs de Google Images a veces tienen parámetros que pueden causar problemas
    if (url.contains('googleusercontent.com') || url.contains('google.com/imgres')) {
      // Si es una URL de Google Images, intentar extraer la URL directa
      // Formato común: https://www.google.com/imgres?imgurl=URL_DIRECTA&...
      final imgUrlMatch = RegExp(r'[?&]imgurl=([^&]+)').firstMatch(url);
      if (imgUrlMatch != null) {
        return Uri.decodeComponent(imgUrlMatch.group(1)!);
      }
      
      // Si contiene googleusercontent.com, puede ser una URL directa
      if (url.contains('googleusercontent.com')) {
        // Limpiar parámetros innecesarios que puedan causar problemas
        final uri = Uri.tryParse(url);
        if (uri != null) {
          // Mantener solo los parámetros esenciales
          return uri.replace(queryParameters: {}).toString();
        }
      }
    }
    
    // Para otras URLs, devolver tal cual
    return url;
  }

  final List<Map<String, String>> hotels = const [
    {
      'name': 'Hotel Sol',
      'url': 'https://hotelyhostalsol.com/',
      'phone': '925 21 36 50',
      'discount': 'Llamar por teléfono y decir Boda Carlos y Cristina',
      'location': 'https://maps.app.goo.gl/wtdanRcY6GAZkfZu5',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&h=300&fit=crop',
    },
    {
      'name': 'Hostal Sol',
      'url': 'https://hotelyhostalsol.com/',
      'phone': '925 21 36 50',
      'discount': 'Llamar por teléfono y decir Boda Carlos y Cristina',
      'location': 'https://maps.app.goo.gl/wtdanRcY6GAZkfZu5',
      'image': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500&h=300&fit=crop',
    },
    {
      'name': 'Los Cigarrales',
      'url': 'https://hotelcigarrales.com/',
      'phone': '925 22 00 53',
      'discount': 'BODACRCA10102026',
      'location': 'https://maps.app.goo.gl/DmE2QdaScTXgkoHj7',
      'image': 'https://images.unsplash.com/photo-1551882547-ff43c63faf76?w=500&h=300&fit=crop',
    },
    {
      'name': 'Eurostars Toledo 4*',
      'url': 'https://www.eurostarshotels.com/eurostars-toledo.html?referer_code=lb0gg00yx&utm_source=google&utm_medium=business&utm_campaign=lb0gg00yx',
      'phone': '925 28 23 73',
      'location': 'https://maps.app.goo.gl/25DSEfLXcoZ34RuL6',
      'image': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=500&h=300&fit=crop',
    },
    {
      'name': 'Sercotel Renacimiento',
      'url': 'https://www.sercotelhoteles.com/es/hotel-toledo-renacimiento?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/Zw2gYQ96bAqBXLTD8',
      'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500&h=300&fit=crop',
    },
    {
      'name': 'Sercotel Toledo Imperial',
      'url': 'https://www.sercotelhoteles.com/es/hotel-toledo-imperial?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/6Zf6xrcrriCfeaZr6',
      'image': 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=500&h=300&fit=crop',
    },
    {
      'name': 'Sercotel Alfonso VI',
      'url': 'https://www.sercotelhoteles.com/es/hotel-alfonso-vi?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/BGBZiwddvAsEsL3p9',
      'image': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=500&h=300&fit=crop',
    },
    {
      'name': 'AC Hotel',
      'url': 'https://www.marriott.com/en-us/hotels/madto-ac-hotel-ciudad-de-toledo/overview/?scid=f2ae0541-1279-4f24-b197-a979c79310b0',
      'phone': '925 28 51 25',
      'location': 'https://maps.app.goo.gl/u6HnGqpyHVYnw9ks6',
      'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=500&h=300&fit=crop',
    },
    {
      'name': 'Hotel Abad',
      'url': 'https://www.hotelabad.com/es/',
      'phone': '925 28 35 00',
      'location': 'https://maps.app.goo.gl/HFEGtyB5X8Kffy4YA',
      'image': 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=500&h=300&fit=crop',
    },
    {
      'name': 'Hotel Beatriz',
      'url': 'https://www.beatrizhoteles.com/es/hotel-beatriz-toledo-auditorium-spa-en-toledo/?partner=5119',
      'phone': '925 26 91 00',
      'location': 'https://maps.app.goo.gl/Rz3qGDgppxqb7xPR6',
      'image': 'https://images.unsplash.com/photo-1551882547-ff43c63ebb7a?w=500&h=300&fit=crop',
    },
    {
      'name': 'El Bosque',
      'url': 'https://www.hotelcigarralelbosque.com/',
      'phone': '925 28 56 40',
      'location': 'https://maps.app.goo.gl/x76con9vkX7CtaR87',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&h=300&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: WeddingColors.backgroundLight,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            child: Text(
              'Hoteles Recomendados',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: WeddingColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          Stack(
            children: [
              SizedBox(
                height: isMobile ? 320 : 360,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
                  clipBehavior: Clip.none,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      hotels.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: index < hotels.length - 1 ? 20 : 0,
                        ),
                        child: _buildHotelCard(context, hotels[index], isMobile),
                      ),
                    ),
                  ),
                ),
              ),
              // Flecha izquierda
              if (_canScrollLeft)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: WeddingColors.backgroundWhite,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: WeddingColors.burgundyPrimary,
                          size: 32,
                        ),
                        onPressed: _scrollLeft,
                        tooltip: 'Desplazar hacia la izquierda',
                      ),
                    ),
                  ),
                ),
              // Flecha derecha
              if (_canScrollRight)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: WeddingColors.backgroundWhite,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: WeddingColors.burgundyPrimary,
                          size: 32,
                        ),
                        onPressed: _scrollRight,
                        tooltip: 'Desplazar hacia la derecha',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context, Map<String, String> hotel, bool isMobile) {
    final cardWidth = isMobile ? 260.0 : 280.0;
    
    return _DraggableCard(
      onTap: () => _showHotelDialog(context, hotel),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: WeddingColors.backgroundWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: WeddingColors.borderColor,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: hotel['image'] != null && hotel['image']!.isNotEmpty
                    ? _buildNetworkImage(hotel['image']!)
                    : _buildPlaceholderImage(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: WeddingColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Ver más',
                          style: TextStyle(
                            color: WeddingColors.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16, color: WeddingColors.iconColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHotelDialog(BuildContext context, Map<String, String> hotel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 16 : 24,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 500,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header con nombre y botón cerrar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name']!,
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w600,
                            color: WeddingColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: WeddingColors.iconColor),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 20 : 24),
                  
                  // Información del hotel
                  _buildInfoRow(
                    icon: Icons.language,
                    label: 'Sitio web',
                    value: hotel['name']!,
                    onTap: () => html.window.open(hotel['url']!, '_blank'),
                    isMobile: isMobile,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  
                  _buildInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: hotel['phone']!,
                    onTap: () => html.window.open('tel:${hotel['phone']}', '_self'),
                    isMobile: isMobile,
                  ),
                  
                  // Mostrar descuento solo si existe y no es null
                  if (hotel['discount'] != null && hotel['discount']!.isNotEmpty) ...[
                    SizedBox(height: isMobile ? 12 : 16),
                    _buildInfoRow(
                      icon: Icons.local_offer,
                      label: 'Descuento',
                      value: hotel['discount']!,
                      onTap: null,
                      isMobile: isMobile,
                      isSelectable: true,
                    ),
                  ],
                  
                  SizedBox(height: isMobile ? 12 : 16),
                  
                  _buildInfoRow(
                    icon: Icons.location_on,
                    label: 'Ubicación',
                    value: 'Ver en mapa',
                    onTap: () => html.window.open(hotel['location']!, '_blank'),
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback? onTap,
    bool isMobile = false,
    bool isSelectable = false,
  }) {
    final isClickable = onTap != null;
    
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: WeddingColors.iconColor,
          size: isMobile ? 20 : 24,
        ),
        SizedBox(width: isMobile ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  color: WeddingColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              isSelectable
                  ? SelectableText(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: isClickable 
                            ? WeddingColors.burgundyPrimary 
                            : WeddingColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        decoration: isClickable ? TextDecoration.underline : null,
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: isClickable 
                            ? WeddingColors.burgundyPrimary 
                            : WeddingColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        decoration: isClickable ? TextDecoration.underline : null,
                      ),
                      maxLines: isMobile ? 2 : null,
                      overflow: isMobile ? TextOverflow.ellipsis : null,
                    ),
            ],
          ),
        ),
        if (isClickable)
          Icon(
            Icons.open_in_new,
            size: isMobile ? 16 : 18,
            color: WeddingColors.iconColor,
          ),
      ],
    );

    if (isClickable) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 6 : 8),
          child: content,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(isMobile ? 6 : 8),
      child: content,
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 180,
      width: double.infinity,
      color: WeddingColors.backgroundLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hotel,
            size: 48,
            color: WeddingColors.iconColor.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'Hotel',
            style: TextStyle(
              fontSize: 14,
              color: WeddingColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkImage(String imageUrl) {
    // Procesar la URL para asegurar que sea una URL directa
    final processedUrl = _processImageUrl(imageUrl);
    
    // Para URLs de cdrst.com, usar un widget especial que maneja mejor CORS
    if (processedUrl.contains('cdrst.com')) {
      return _CdrstImageWidget(imageUrl: processedUrl);
    }
    
    // Para otras URLs, usar Image.network primero
    return Image.network(
      processedUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 180,
          color: Colors.grey.shade200,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: WeddingColors.iconColor,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Si falla, mostrar placeholder
        return Container(
          height: 180,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.hotel, size: 50, color: Colors.grey),
          ),
        );
      },
    );
  }
}

// Widget que permite diferenciar entre arrastre y click
class _DraggableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _DraggableCard({
    required this.child,
    required this.onTap,
  });

  @override
  State<_DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<_DraggableCard> {
  Offset? _pointerDownPosition;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _pointerDownPosition = event.position;
        _isDragging = false;
      },
      onPointerMove: (event) {
        if (_pointerDownPosition != null) {
          final delta = (event.position - _pointerDownPosition!);
          // Si el movimiento horizontal es mayor que el vertical, es un arrastre
          if (delta.dx.abs() > 10 || delta.dy.abs() > 10) {
            _isDragging = true;
          }
        }
      },
      onPointerUp: (event) {
        if (!_isDragging && _pointerDownPosition != null) {
          // Solo hacer click si no hubo arrastre significativo
          widget.onTap();
        }
        _pointerDownPosition = null;
        _isDragging = false;
      },
      child: widget.child,
    );
  }
}

// Widget especial para cargar imágenes de cdrst.com
// Usa múltiples estrategias para evitar problemas de CORS
class _CdrstImageWidget extends StatefulWidget {
  final String imageUrl;

  const _CdrstImageWidget({required this.imageUrl});

  @override
  State<_CdrstImageWidget> createState() => _CdrstImageWidgetState();
}

class _CdrstImageWidgetState extends State<_CdrstImageWidget> {
  bool _isLoading = true;
  bool _hasError = false;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _tryLoadImage();
  }

  void _tryLoadImage() {
    // Crear un elemento img HTML para verificar si la imagen se puede cargar
    final img = html.ImageElement()
      ..src = widget.imageUrl
      ..crossOrigin = 'anonymous'; // Intentar con CORS anónimo

    img.onLoad.listen((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = false;
          _imageLoaded = true;
        });
      }
    });

    img.onError.listen((_) {
      // Si falla con CORS anónimo, intentar sin CORS
      if (mounted && !_imageLoaded) {
        final img2 = html.ImageElement()..src = widget.imageUrl;
        img2.onLoad.listen((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = false;
              _imageLoaded = true;
            });
          }
        });
        img2.onError.listen((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          }
        });
      } else if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      // Si hay error, intentar una última vez con Image.network
      return Image.network(
        widget.imageUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 180,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.hotel, size: 50, color: Colors.grey),
            ),
          );
        },
      );
    }

    if (_isLoading) {
      return Container(
        height: 180,
        color: Colors.grey.shade200,
        child: Center(
          child: CircularProgressIndicator(
            color: WeddingColors.iconColor,
          ),
        ),
      );
    }

    // Si la imagen se cargó correctamente, usar Image.network
    // El navegador ya tiene la imagen en caché, así que debería funcionar
    return Image.network(
      widget.imageUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 180,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.hotel, size: 50, color: Colors.grey),
          ),
        );
      },
    );
  }
}

