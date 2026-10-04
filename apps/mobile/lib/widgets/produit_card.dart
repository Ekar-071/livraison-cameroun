import 'package:flutter/material.dart';

import '../models/produit.dart';
import '../theme/app_colors.dart';

class ProduitCard extends StatelessWidget {
  final Produit produit;
  final VoidCallback onAjouter;

  const ProduitCard({
    super.key,
    required this.produit,
    required this.onAjouter,
  });

  String get image {
    final nom = produit.nom.toLowerCase();

    if (nom.contains("riz")) {
      return "assets/images/produits/riz.jpg";
    }

    if (nom.contains("huile")) {
      return "assets/images/produits/huile.jpg";
    }

    if (nom.contains("sucre")) {
      return "assets/images/produits/sucre.jpg";
    }

    if (nom.contains("lait")) {
      return "assets/images/produits/lait.jpg";
    }

    if (nom.contains("pain")) {
      return "assets/images/produits/pain.jpg";
    }

    return "assets/images/produits/default.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                right: 15,
                top: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite_border,
                    color: AppColors.primary,
                  ),
                ),
              ),

              Positioned(
                left: 15,
                bottom: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "${produit.prix.toStringAsFixed(0)} FCFA",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  produit.nom,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  produit.description ?? "Produit disponible",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),

                    const SizedBox(width: 5),

                    const Text(
                      "4.8",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton.icon(
                      onPressed: onAjouter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Ajouter"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}