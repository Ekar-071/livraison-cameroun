import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/commande_service.dart';
import '../services/panier_service.dart';
import '../theme/app_colors.dart';
import '../widgets/panier_item_card.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  final PanierService panier = PanierService();
  final CommandeService commandeService = CommandeService();

  static const double fraisLivraison = 500;

  @override
  Widget build(BuildContext context) {
    final total = panier.total;
    final totalGeneral = total + fraisLivraison;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Mon panier",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: panier.estVide
          ? const Center(
              child: Text(
                "Votre panier est vide",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        "Votre commande",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      ...panier.items.map(
                        (item) => PanierItemCard(
                          item: item,
                          onAjouter: () {
                            setState(() {
                              panier.incrementer(item.produit.id);
                            });
                          },
                          onRetirer: () {
                            setState(() {
                              panier.decrementer(item.produit.id);
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _ligne(
                              "Sous-total",
                              "${total.toStringAsFixed(0)} FCFA",
                            ),

                            const SizedBox(height: 12),

                            _ligne(
                              "Livraison",
                              "${fraisLivraison.toStringAsFixed(0)} FCFA",
                            ),

                            const Divider(height: 30),

                            _ligne(
                              "Total",
                              "${totalGeneral.toStringAsFixed(0)} FCFA",
                              gras: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),

                SafeArea(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            final auth = context.read<AuthProvider>();

                            if (!auth.estConnecte ||
                                auth.utilisateurId == null) {
                              throw Exception(
                                "Utilisateur non connecté",
                              );
                            }

                            await commandeService.creerCommande(
                              utilisateurId: auth.utilisateurId!,
                              modePaiement: "ESPECES",
                            );

                            if (!mounted) return;

                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Commande enregistrée avec succès.",
                                ),
                              ),
                            );

                            Navigator.pop(context);
                          } catch (e) {
                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Commander maintenant",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _ligne(
    String titre,
    String valeur, {
    bool gras = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titre,
          style: TextStyle(
            fontSize: gras ? 20 : 16,
            fontWeight: gras ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          valeur,
          style: TextStyle(
            fontSize: gras ? 20 : 16,
            fontWeight: gras ? FontWeight.bold : FontWeight.normal,
            color: gras ? AppColors.primary : Colors.black,
          ),
        ),
      ],
    );
  }
}