import 'dart:convert';

import 'package:http/http.dart' as http;

import 'panier_service.dart';

class CommandeService {
  static const String baseUrl = "http://192.168.0.16:3000";
  Future<void> creerCommande({
    required String utilisateurId,
    required String modePaiement,
  }) async {
    final panier = PanierService();

    final response = await http.post(
      Uri.parse("$baseUrl/commandes"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "utilisateurId": utilisateurId,
        "modePaiement": modePaiement,
        "items": panier.items
            .map(
              (item) => {
                "produitId": item.produit.id,
                "quantite": item.quantite,
                "prixUnitaire": item.produit.prix,
              },
            )
            .toList(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }

    panier.vider();
  }
}