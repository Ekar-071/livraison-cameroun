import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/utilisateur.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  Utilisateur? _utilisateur;

  String? get token => _token;
  Utilisateur? get utilisateur => _utilisateur;
  String? get utilisateurId => _utilisateur?.id;

  bool get estConnecte => _token != null;

  Future<void> connecter({
    required String token,
    required Utilisateur utilisateur,
  }) async {
    _token = token;
    _utilisateur = utilisateur;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);
    await prefs.setString("utilisateurId", utilisateur.id);

    notifyListeners();
  }

  Future<void> deconnecter() async {
    _token = null;
    _utilisateur = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> chargerSession() async {
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString("token");

    final utilisateurId = prefs.getString("utilisateurId");

    if (utilisateurId != null) {
      _utilisateur = Utilisateur(
        id: utilisateurId,
        prenom: "",
        nom: "",
        telephone: "",
        email: null,
        role: "",
      );
    }

    notifyListeners();
  }
}