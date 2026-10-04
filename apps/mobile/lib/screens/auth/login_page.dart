import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final telephoneController = TextEditingController();
  final motDePasseController = TextEditingController();

  final AuthService authService = AuthService();

  bool chargement = false;

  @override
  void dispose() {
    telephoneController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: telephoneController,
              decoration: const InputDecoration(
                labelText: "Téléphone",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: motDePasseController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: chargement
                    ? null
                    : () async {
                        setState(() {
                          chargement = true;
                        });

                        try {
                          final resultat = await authService.login(
                            telephone: telephoneController.text.trim(),
                            motDePasse: motDePasseController.text,
                          );

                          await context.read<AuthProvider>().connecter(
                                token: resultat["token"],
                                utilisateur: resultat["utilisateur"],
                              );

                          if (!mounted) return;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainNavigation(),
                            ),
                          );
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              chargement = false;
                            });
                          }
                        }
                      },
                child: chargement
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Se connecter"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}