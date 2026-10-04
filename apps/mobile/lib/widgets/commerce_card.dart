import 'package:flutter/material.dart';

import '../models/commerce.dart';
import '../theme/app_colors.dart';

class CommerceCard extends StatelessWidget {
  final Commerce commerce;
  final VoidCallback onTap;

  const CommerceCard({
    super.key,
    required this.commerce,
    required this.onTap,
  });

  String get image {
    final nom = commerce.nom.toLowerCase();

    if (nom.contains("super")) {
      return "assets/images/commerces/supermarket.jpg";
    }

    if (nom.contains("carrefour")) {
      return "assets/images/commerces/carrefour.jpg";
    }

    if (nom.contains("casino")) {
      return "assets/images/commerces/casino.jpg";
    }

    return "assets/images/commerces/store.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black12,
              offset: Offset(0, 5),
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
                    height: 180,
                    width: double.infinity,
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
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "OUVERT",
                      style: TextStyle(
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
                    commerce.nom,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    commerce.adresse,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: const [

                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),

                      SizedBox(width: 5),

                      Text(
                        "4.8",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacer(),

                      Icon(Icons.delivery_dining),

                      SizedBox(width: 6),

                      Text("25-35 min"),

                      SizedBox(width: 15),

                      Icon(Icons.location_on),

                      SizedBox(width: 5),

                      Text("2 km"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}