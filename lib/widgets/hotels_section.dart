import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HotelsSection extends StatelessWidget {
  const HotelsSection({super.key});

  final List<Map<String, String>> hotels = const [
    {
      'name': 'Hotel Parador de Toledo',
      'url': 'https://www.parador.es/es/paradores/parador-de-toledo',
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
    },
    {
      'name': 'Hotel Cigarral El Bosque',
      'url': 'https://www.cigarralelbosque.com',
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
    },
    {
      'name': 'Hotel Eurostars Toledo',
      'url': 'https://www.eurostars.com',
      'image': 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400',
    },
    {
      'name': 'Hotel San Juan de los Reyes',
      'url': 'https://www.hotelsanjuan.com',
      'image': 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        color: WeddingColors.backgroundLight,
      ),
      child: Column(
        children: [
          Text(
            'Hoteles Recomendados',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 40),
          
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: hotels.map((hotel) => _buildHotelCard(context, hotel)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context, Map<String, String> hotel) {
    return GestureDetector(
      onTap: () {
        html.window.open(hotel['url']!, '_blank');
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: WeddingColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: WeddingColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: WeddingColors.shadowColor,
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                hotel['image']!,
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
              ),
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
    );
  }
}

