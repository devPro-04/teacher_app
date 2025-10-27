import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/session_details.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen>
    with WidgetsBindingObserver {
  final apiConnection = ApiConnection();
  final _localStorage = LocalStorage();
  List<SessionModel> _sessions = [];
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchSessions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // L'utilisateur revient sur l'écran (ou l'application)
      _fetchSessions();
      _startTimer();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // L'utilisateur quitte l'écran (ou l'application passe en arrière-plan)
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Annule tout timer existant
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      _fetchSessions();
    });
  }

  Future<void> _fetchSessions() async {
    try {
      final sessions = await apiConnection.getSessions();
      if (mounted) {
        setState(() {
          _sessions = sessions;
          print(_sessions);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // Gérer l'erreur, par exemple en affichant un message ou en loguant
      print('Erreur lors de la récupération des sessions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF005BFE)))
            : _sessions.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(230, 231, 234, 1)),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 16),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Expand icon
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/icon10.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Main title
                            const Text(
                              'Aucune session planifiée',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(4, 19, 44, 1),
                                letterSpacing: -0.44,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 12),

                            // Subtitle
                            const Text(
                              'Acceptez des missions pour voir vos sessions ici',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(129, 137, 149, 1),
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: _sessions.map((wsession) {
                      return SessionDetails(
                        model: wsession,
                      ); // Example: A custom Widget
                    }).toList(),
                  ));
  }
}
