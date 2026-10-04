import 'package:flutter/material.dart';

import '../models/ville.dart';
import '../theme/app_colors.dart';

class VilleCard extends StatelessWidget {
  final Ville ville;
  final VoidCallback onTap;

  const VilleCard({
    super.key,
    required this.ville,
    required this.onTap,
  });

  String get image {
    switch (ville.nom.toLowerCase()) {
      case "douala":
        return "assets/images/villes/douala.jpg";

      case "yaoundé":
      case "yaounde":
        return "assets/images/villes/yaounde.jpg";

      case "bafoussam":
        return "assets/images/villes/bafoussam.jpg";

      case "garoua":
        return "assets/images/villes/garoua.jpg";

      case "limbe":
        return "assets/images/villes/limbe.jpg";

      case "ngaoundéré":
      case "ngaoundere":
        return "assets/images/villes/ngaoundere.jpg";

      case "kribi":
        return "assets/images/villes/kribi.jpg";

      case "bertoua":
        return "assets/images/villes/bertoua.jpg";

      case "maroua":
        return "assets/images/villes/maroua.jpg";

      case "ebolowa":
        return "assets/images/villes/ebolowa.jpg";

      default:
        return "assets/images/villes/douala.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  ville.nom,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Livraison rapide",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}