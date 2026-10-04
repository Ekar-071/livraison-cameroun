import 'package:flutter/material.dart';

import '../models/commerce.dart';
import '../models/ville.dart';
import '../services/commerce_service.dart';
import '../widgets/commerce_card.dart';
import 'produits_page.dart';

class CommercesPage extends StatefulWidget {
  final Ville ville;

  const CommercesPage({
    super.key,
    required this.ville,
  });

  @override
  State<CommercesPage> createState() => _CommercesPageState();
}

class _CommercesPageState extends State<CommercesPage> {
  final CommerceService _commerceService = CommerceService();

  late Future<List<Commerce>> _futureCommerces;

  @override
  void initState() {
    super.initState();
    _futureCommerces =
        _commerceService.getCommercesByVille(widget.ville.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(
          widget.ville.nom,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<Commerce>>(
        future: _futureCommerces,
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

          final commerces = snapshot.data ?? [];

          if (commerces.isEmpty) {
            return const Center(
              child: Text(
                "Aucun commerce disponible.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                "Découvrez les commerces de ${widget.ville.nom}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Choisissez un commerce pour commencer vos achats.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              ...commerces.map(
                (commerce) => CommerceCard(
                  commerce: commerce,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProduitsPage(
                          commerce: commerce,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}