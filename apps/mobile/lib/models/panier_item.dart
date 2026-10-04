import 'produit.dart';

class PanierItem {
  final Produit produit;
  int quantite;

  PanierItem({
    required this.produit,
    this.quantite = 1,
  });

  double get total => produit.prix * quantite;
}