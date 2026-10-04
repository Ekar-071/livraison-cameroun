import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      Icons.shopping_basket,
      Icons.restaurant,
      Icons.local_pharmacy,
      Icons.bakery_dining,
    ];

    final titres = [
      "Supermarchés",
      "Restaurants",
      "Pharmacies",
      "Boulangeries",
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  child: Icon(categories[index]),
                ),

                const SizedBox(height: 10),

                Text(
                  titres[index],
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}