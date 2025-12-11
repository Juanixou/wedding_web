import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HairSalonsSection extends StatelessWidget {
  const HairSalonsSection({super.key});

  final List<Map<String, String>> salons = const [
    {
      'name': 'Peluquería Estilo',
      'url': 'https://www.peluqueriaestilo.com',
      'image': 'https://images.unsplash.com/photo-1562322140-8baeececf3df?w=400',
    },
    {
      'name': 'Salón de Belleza Elegance',
      'url': 'https://www.salonelegance.com',
      'image': 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            'Peluquerías Recomendadas',
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
            children: salons.map((salon) => _buildSalonCard(context, salon)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSalonCard(BuildContext context, Map<String, String> salon) {
    return GestureDetector(
      onTap: () {
        html.window.open(salon['url']!, '_blank');
      },
      child: Container(
        width: 350,
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
                salon['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.content_cut, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salon['name']!,
                    style: TextStyle(
                      fontSize: 20,
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

