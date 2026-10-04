import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/utilisateur.dart';

class AuthService {
  static const String baseUrl = "http://192.168.0.16:3000";

  Future<Map<String, dynamic>> login({
    required String telephone,
    required String motDePasse,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "telephone": telephone,
        "motDePasse": motDePasse,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }

    final json = jsonDecode(response.body);

    return {
      "token": json["accessToken"],
      "utilisateur": Utilisateur.fromJson(json["utilisateur"]),
    };
  }

  Future<void> register({
    required String prenom,
    required String nom,
    required String telephone,
    String? email,
    required String motDePasse,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "prenom": prenom,
        "nom": nom,
        "telephone": telephone,
        "email": email,
        "motDePasse": motDePasse,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}