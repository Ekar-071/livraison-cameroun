class Utilisateur {
  final String id;
  final String prenom;
  final String nom;
  final String telephone;
  final String? email;
  final String role;

  Utilisateur({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.telephone,
    this.email,
    required this.role,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json["id"],
      prenom: json["prenom"],
      nom: json["nom"],
      telephone: json["telephone"],
      email: json["email"],
      role: json["role"],
    );
  }
}