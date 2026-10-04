import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/produit.dart';

class ProduitService {
static const String baseUrl = "http://192.168.0.16:3000";

  Future<List<Produit>> getProduits(String commerceId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/produits/commerce/$commerceId'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Produit.fromJson(e)).toList();
    }

    throw Exception('Impossible de charger les produits');
  }
}