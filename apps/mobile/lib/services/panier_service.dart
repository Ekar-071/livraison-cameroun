import '../models/panier_item.dart';
import '../models/produit.dart';

class PanierService {
  static final PanierService _instance = PanierService._internal();

  factory PanierService() => _instance;

  PanierService._internal();

  final List<PanierItem> _items = [];

  List<PanierItem> get items => List.unmodifiable(_items);

  void ajouterProduit(Produit produit) {
    final index = _items.indexWhere((e) => e.produit.id == produit.id);

    if (index != -1) {
      _items[index].quantite++;
    } else {
      _items.add(PanierItem(produit: produit));
    }
  }

  void incrementer(String produitId) {
    final item = _items.firstWhere((e) => e.produit.id == produitId);
    item.quantite++;
  }

  void decrementer(String produitId) {
    final item = _items.firstWhere((e) => e.produit.id == produitId);

    if (item.quantite > 1) {
      item.quantite--;
    } else {
      _items.remove(item);
    }
  }

  void supprimer(String produitId) {
    _items.removeWhere((e) => e.produit.id == produitId);
  }

  double get total =>
      _items.fold(0, (total, item) => total + item.total);

  int get nombreArticles =>
      _items.fold(0, (total, item) => total + item.quantite);

  bool get estVide => _items.isEmpty;

  void vider() {
    _items.clear();
  }
}