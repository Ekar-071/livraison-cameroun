import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/commerce.dart';

class CommerceService {
  static const String baseUrl = "http://192.168.0.16:3000";
  Future<List<Commerce>> getCommercesByVille(String villeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/commerces/ville/$villeId'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Commerce.fromJson(e)).toList();
    }

    throw Exception('Impossible de charger les commerces');
  }
}