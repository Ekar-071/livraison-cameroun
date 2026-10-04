import 'package:flutter/material.dart';

import '../models/panier_item.dart';
import '../theme/app_colors.dart';

class PanierItemCard extends StatelessWidget {
  final PanierItem item;
  final VoidCallback onAjouter;
  final VoidCallback onRetirer;

  const PanierItemCard({
    super.key,
    required this.item,
    required this.onAjouter,
    required this.onRetirer,
  });

  String get image {
    final nom = item.produit.nom.toLowerCase();

    if (nom.contains("huile")) {
      return "assets/images/produits/huile.jpg";
    }

    if (nom.contains("riz")) {
      return "assets/images/produits/riz.jpg";
    }

    if (nom.contains("sucre")) {
      return "assets/images/produits/sucre.jpg";
    }

    if (nom.contains("savon")) {
      return "assets/images/produits/savon.jpg";
    }

    if (nom.contains("lait")) {
      return "assets/images/produits/lait.jpg";
    }

    if (nom.contains("pâte") || nom.contains("pate")) {
      return "assets/images/produits/pates.jpg";
    }

    return "assets/images/produits/riz.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.produit.nom,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    item.produit.description ?? "",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "${item.produit.prix.toStringAsFixed(0)} FCFA",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          icon: const Icon(Icons.remove),
                          onPressed: onRetirer,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          item.quantite.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          color: Colors.white,
                          icon: const Icon(Icons.add),
                          onPressed: onAjouter,
                        ),
                      ),
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