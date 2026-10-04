import 'package:flutter/material.dart';

import '../services/panier_service.dart';

class PanierBadge extends StatelessWidget {
  final VoidCallback onPressed;

  const PanierBadge({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final panier = PanierService();

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: onPressed,
        ),

        if (panier.items.isNotEmpty)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                panier.items.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}