class Commerce {
  final String id;
  final String nom;
  final String? description;
  final String adresse;
  final String telephone;
  final String? image;

  const Commerce({
    required this.id,
    required this.nom,
    this.description,
    required this.adresse,
    required this.telephone,
    this.image,
  });

  factory Commerce.fromJson(Map<String, dynamic> json) {
    return Commerce(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      adresse: json['adresse'],
      telephone: json['telephone'],
      image: json['image'],
    );
  }
}