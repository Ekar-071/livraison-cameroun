import 'package:flutter/material.dart';

import 'home_page.dart';
import 'orders_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final pages = const [

    HomePage(),

    SearchPage(),

    OrdersPage(),

    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected: (index){

          setState(() {

            currentIndex=index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: "Accueil",

          ),

          NavigationDestination(

            icon: Icon(Icons.search),

            label: "Recherche",

          ),

          NavigationDestination(

            icon: Icon(Icons.receipt_long_outlined),

            selectedIcon: Icon(Icons.receipt_long),

            label: "Commandes",

          ),

          NavigationDestination(

            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: "Profil",

          ),

        ],

      ),

    );

  }

}