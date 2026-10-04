class Produit {
  final String id;
  final String nom;
  final String? description;
  final double prix;
  final String? image;

  const Produit({
    required this.id,
    required this.nom,
    this.description,
    required this.prix,
    this.image,
  });

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      prix: double.parse(json['prix'].toString()),
      image: json['image'],
    );
  }
}