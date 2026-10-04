import 'package:flutter/material.dart';

import '../models/commerce.dart';
import '../models/produit.dart';
import '../services/panier_service.dart';
import '../services/produit_service.dart';
import '../theme/app_colors.dart';
import '../widgets/produit_card.dart';
import 'panier_page.dart';

class ProduitsPage extends StatefulWidget {
  final Commerce commerce;

  const ProduitsPage({
    super.key,
    required this.commerce,
  });

  @override
  State<ProduitsPage> createState() => _ProduitsPageState();
}

class _ProduitsPageState extends State<ProduitsPage> {
  final ProduitService _produitService = ProduitService();
  final PanierService _panierService = PanierService();

  late Future<List<Produit>> _futureProduits;

  @override
  void initState() {
    super.initState();
    _futureProduits =
        _produitService.getProduits(widget.commerce.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.commerce.nom,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PanierPage(),
                    ),
                  );

                  setState(() {});
                },
              ),

              if (_panierService.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _panierService.items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: FutureBuilder<List<Produit>>(
        future: _futureProduits,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final produits = snapshot.data ?? [];

          if (produits.isEmpty) {
            return const Center(
              child: Text(
                "Aucun produit disponible",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                widget.commerce.nom,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Choisissez vos produits favoris.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              ...produits.map(
                (produit) => ProduitCard(
                  produit: produit,
                  onAjouter: () {
                    _panierService.ajouterProduit(produit);

                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 1),
                        content: Text(
                          "${produit.nom} ajouté au panier",
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 120),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.shopping_cart_checkout),
        label: Text(
          "Panier (${_panierService.items.length})",
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PanierPage(),
            ),
          );

          setState(() {});
        },
      ),
    );
  }
}