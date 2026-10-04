class Ville {
  final String id;
  final String nom;

  const Ville({
    required this.id,
    required this.nom,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      id: json['id'] as String,
      nom: json['nom'] as String,
    );
  }
}