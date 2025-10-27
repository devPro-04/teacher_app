import 'package:flutter/material.dart';
import 'package:olinom/screens/login_screen.dart';
import 'package:olinom/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  // Fonction pour ouvrir le lien dans le navigateur
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://e-campus.olinom.com/candidature');
    if (!await launchUrl(url)) {
      throw Exception('Impossible d\'ouvrir le lien: $url');
    }
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF337CFE), // rgba(51,124,254,1)
                      Color(0xFF005BFE), // rgba(0,91,254,1)
                    ],
                    stops: [0.0, 0.61],
                  ),
                ),
              ),
            ),

            // Background image with overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/images/group-educator.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 176,
                    height: 90,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/group_3.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Tagline
                  Container(
                    width: 349,
                    margin: const EdgeInsets.only(bottom: 48),
                    child: const Text(
                      'Le premier service de\nremplacement d\'enseignants digital de France',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  // Buttons
                  SizedBox(
                    width: 270,
                    child: Column(
                      children: [
                        CustomButton(
                          text: 'Se connecter',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          backgroundColor: const Color(0xFF005BFE), // blue-600
                          textColor: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 9),
                        CustomButton(
                          text: 'S\'inscrire',
                          onPressed: _launchUrl,
                          backgroundColor: const Color(0xFF00E0E8), // cyan
                          textColor: const Color(0xFF04132C),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
