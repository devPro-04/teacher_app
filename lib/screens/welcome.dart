import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/session_screen.dart';
import 'package:olinom/widgets/appbar.dart';
import 'package:olinom/widgets/welcomemission.dart';
import 'package:olinom/widgets/welcomesession.dart';
import 'package:olinom/services/api_connection.dart';
import '../Models/mission_model.dart';
import '../Models/session_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Timer? _syncTimer;
  bool isSessionNull = false;
  bool isMissionNull = false;

  // Variables pour stocker les données
  List<MissionModel> missions = [];
  List<SessionModel> sessions = [];
  dynamic expectanswer;
  dynamic totalsessions;

  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeData();
    startPeriodicSync();
  }

  @override
  void dispose() {
    stopSync();
    super.dispose();
  }

  void _initializeData() async {
    try {
      await fetchAllData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void startPeriodicSync() {
    // Arrêter le timer existant
    _syncTimer?.cancel();

    // Synchroniser toutes les minutes
    _syncTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _syncData();
    });
  }

  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  Future<void> _syncData() async {
    try {
      await fetchAllData();
      print(
          'Synchronisation réussie - ${missions.length} missions, ${sessions.length} sessions');
    } catch (e) {
      print('Erreur de synchronisation: $e');
    }
  }

  Future<void> fetchAllData() async {
    try {
      final apiConnection = ApiConnection();
      final results = await Future.wait([
        apiConnection.getWelcomeExpectedAnswer(),
        apiConnection.getWelcomeTotalWeekSession(),
        apiConnection.getWelcomeMission(),
        apiConnection.getWelcomeWeekSessions(),
      ]);

      final wmissions = results[2] as List<MissionModel>;
      final wsessions = results[3] as List<SessionModel>;

      // Mettre à jour l'état avec setState pour rafraîchir l'UI
      if (mounted) {
        setState(() {
          expectanswer = results[0];
          totalsessions = results[1];
          missions = wmissions;
          sessions = wsessions;
          isMissionNull = wmissions.isEmpty;
          isSessionNull = wsessions.isEmpty;
        });
      }
    } catch (e) {
      print('Erreur fetchAllData: $e');
      if (mounted) {
        setState(() {
          _error = 'Failed to load data: $e';
        });
      }
      throw Exception('Failed to load data: $e');
    }
  }

  // Fonction pour rafraîchir manuellement
  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await fetchAllData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 64),
            SizedBox(height: 16),
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _refreshData,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 243, 244, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 150,
                    padding: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$expectanswer',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Réponse(s) attendue(s)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 243, 244, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 150,
                    padding: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$totalsessions',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Session(s) cette semaine',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Prochaine demain 09h30mn',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // En attente section
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'En attente de votre réponse',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  if (missions.isNotEmpty) ...[
                    ...missions.map((mission) {
                      return WelcomeMission(mission, "welcome");
                    }).toList(),
                  ],
                  if (isMissionNull) _buildNoMissionsWidget(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sessions section
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color.fromRGBO(230, 231, 234, 1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Vos prochaines sessions',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (sessions.isNotEmpty) ...[
                    ...sessions.map((session) {
                      return WelcomeSession(session);
                    }).toList(),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(
                            color: Color.fromRGBO(4, 19, 44, 1),
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Voir toutes les missions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(4, 19, 44, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (isSessionNull) _buildNoSessionsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoMissionsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(230, 231, 234, 1)),
        boxShadow: [
          BoxShadow(
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
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  'assets/icons/icon9.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Aucune mission en attente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(4, 19, 44, 1),
                  letterSpacing: -0.44,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'De nouvelles opportunités arriveront bientôt',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(129, 137, 149, 1),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: BorderSide(
                      color: Color.fromRGBO(4, 19, 44, 1),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _refreshData,
                  child: const Text(
                    'Actualiser',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      letterSpacing: -0.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoSessionsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(230, 231, 234, 1)),
        boxShadow: [
          BoxShadow(
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
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: BorderSide(
                      color: Color.fromRGBO(4, 19, 44, 1),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _refreshData,
                  child: const Text(
                    'Voir toutes les missions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      letterSpacing: -0.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
