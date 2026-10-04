import 'package:flutter/material.dart';

import '../models/ville.dart';
import '../services/ville_service.dart';
import '../widgets/home/category_section.dart';
import '../widgets/home/home_header.dart';
import '../widgets/home/promo_banner.dart';
import '../widgets/home/search_bar_widget.dart';
import 'commerces_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VilleService _villeService = VilleService();

  late Future<List<Ville>> futureVilles;

  @override
  void initState() {
    super.initState();
    futureVilles = _villeService.getVilles();
  }

  String imageVille(String nom) {
    switch (nom.toLowerCase()) {
      case "douala":
        return "assets/images/villes/douala.jpg";

      case "yaoundé":
      case "yaounde":
        return "assets/images/villes/yaounde.jpg";

      case "bafoussam":
        return "assets/images/villes/bafoussam.jpg";

      case "garoua":
        return "assets/images/villes/garoua.jpg";

      case "bamenda":
        return "assets/images/villes/bamenda.jpg";

      case "limbé":
      case "limbe":
        return "assets/images/villes/limbe.jpg";

      default:
        return "assets/images/villes/douala.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),

      body: SafeArea(
        child: FutureBuilder<List<Ville>>(
          future: futureVilles,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final villes = snapshot.data!;

            return ListView(
              children: [

                const HomeHeader(),

                const SizedBox(height: 20),

                const SearchBarWidget(),

                const PromoBanner(),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Catégories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const CategorySection(),

                const SizedBox(height: 30),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Choisissez votre ville",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                ListView.builder(
                  itemCount: villes.length,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (_, index) {
                    final ville = villes[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CommercesPage(
                              ville: ville,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 180,
                        margin:
                            const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage(
                              imageVille(ville.nom),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(.75),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Align(
                            alignment:
                                Alignment.bottomLeft,
                            child: Row(
                              children: [

                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  ville.nom,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}