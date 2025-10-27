import 'package:flutter/material.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/widgets/custom_checkbox.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';
import 'welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiConnection = ApiConnection();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction pour ouvrir le lien dans le navigateur
  Future<void> _launchUrlInscription() async {
    final Uri url = Uri.parse('https://e-campus.olinom.com/candidature');
    if (!await launchUrl(url)) {
      throw Exception('Impossible d\'ouvrir le lien: $url');
    }
  }

  // Fonction pour ouvrir le lien dans le navigateur
  Future<void> _launchUrlPassword() async {
    final Uri url = Uri.parse(
        'https://olinom.com/reinitialiser-le-mot-de-passe/campus/200');
    if (!await launchUrl(url)) {
      throw Exception('Impossible d\'ouvrir le lien: $url');
    }
  }

  _login() {
    _apiConnection
        .loginCheck(
      _emailController.text,
      _passwordController.text,
    )
        .then((response) async {
      if (response == 'Connexion réussie') {
        showMySnackBar(
          message: response,
          context: context,
          success: true,
        ).then(Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              currentindex: 0,
            ),
          ),
        ));
      } else {
        showMySnackBar(
          message: "Login ou mot de passe incorrect !",
          context: context,
          success: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.75,
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
                  image: DecorationImage(
                    image: AssetImage('assets/images/group-educator.png'),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: SizedBox(
                      width: 176,
                      height: 90,
                      child: Image.asset(
                        'assets/images/group_3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Background image with overlay
            // Login form
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email field
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "S'il vous plaît entrez votre adresse e-mail";
                            }
                            // Regular expression pattern for email validation
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return "Veuillez entrer une adresse e-mail valide";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Adresse email",
                            labelStyle: TextStyle(color: Color(0xFFB0BCD1)),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB0BCD1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFBABFEF)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Password field
                        TextFormField(
                          controller:
                              _passwordController, // Use TextEditingController to manage the text field value
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "s'il vous plait entrez votre mot de passe";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          keyboardType: TextInputType
                              .visiblePassword, // Change to emailAddress for better keyboard
                          decoration: const InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Color(0xFFB0BCD1)),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFB0BCD1))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFBABFEF)))),
                        ),

                        const SizedBox(height: 16),

                        // Remember me and forgot password
                        Row(
                          children: [
                            CustomCheckbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Se souvenir de moi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F5A6B),
                                letterSpacing: -0.40,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _launchUrlPassword,
                              child: const Text(
                                'Mot de passe oublié',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF005BFE),
                                  letterSpacing: -0.44,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Login button
                        MainButton(
                          buttonText: "Se connecter",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                        ),

                        const SizedBox(height: 54),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF818995),
                                letterSpacing: -0.44,
                              ),
                              children: [
                                const TextSpan(text: 'Pas encore de compte? '),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: _launchUrlInscription,
                                    child: const Text(
                                      "S'inscrire",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF818995),
                                        letterSpacing: -0.05,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),

            // Sign up text
          ],
        ),
      ),
    );
  }
}
