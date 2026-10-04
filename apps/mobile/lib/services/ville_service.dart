import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ville.dart';

class VilleService {
  // Remplace cette IP par celle de ton PC
  static const String baseUrl = "http://192.168.0.16:3000";

  Future<List<Ville>> getVilles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/villes'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((json) => Ville.fromJson(json)).toList();
    }

    throw Exception('Impossible de charger les villes');
  }
}