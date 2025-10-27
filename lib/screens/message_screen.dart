import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/chat_class_screen.dart';
import 'package:olinom/screens/session_screen.dart';
import 'package:olinom/widgets/appbar.dart';
import 'package:olinom/widgets/welcomemission.dart';
import 'package:olinom/widgets/welcomesession.dart';
import 'package:olinom/services/api_connection.dart';
import 'dart:async';
import '../Models/mission_model.dart';
import '../Models/session_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Timer _timer;
  bool isSessionNull = false;
  bool isMissionNull = false;
  final TextEditingController _reasonController = TextEditingController();
  String _data = "Initial Data";
  String _searchQuery = "";

  Future<dynamic> fetchAllData(searchtext) async {
    try {
      final apiConnection = ApiConnection();
      final messageRequests =
          await apiConnection.getMessageRequests(searchtext);
      return messageRequests;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  void _onSearchChanged(String value) {
    // Éviter les appels API trop fréquents
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchQuery = value;
          _data = "Search: $value";
        });
      }
    });
  }

  void _refreshData() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Appel initial au chargement de l'écran
    fetchAllData(_reasonController.text);
    // Démarrer le Timer pour un rafraîchissement toutes les minutes (60 secondes)
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Recharger les données et reconstruire le widget
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Annuler le Timer pour éviter les fuites de mémoire quand le widget est détruit
    _timer.cancel();
    _reasonController
        .dispose(); // Bonne pratique : libérer le contrôleur de texte
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchAllData(_reasonController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 64),
                SizedBox(height: 16),
                Text('Error1: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: () => setState(() {}), // Rebuild to retry
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        if (data == null) {
          return Center(child: Text('No data available'));
        }

        // Try to access replacementRequests safely
        List<dynamic> replacementRequests = [];

        if (data is Map<String, dynamic>) {
          replacementRequests =
              (data['replacementRequests'] as List<dynamic>?) ?? [];
        } else if (data is List<dynamic>) {
          replacementRequests = data;
        }
        final unreadCounts = data['unreadCounts'] ?? [];

        return Column(children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFD2D2D7).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Déclarer une raison";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.webSearch,
                      controller: _reasonController,
                      maxLines: null,
                      expands: true,
                      textAlign: TextAlign.left,
                      onFieldSubmitted: (value) {
                        setState(() {
                          // Update your data here, e.g., fetch new data from an API
                          _data = "New Data: ${DateTime.now().second}";
                        });
                        // or do whatever you want when you are done editing
                        // call your method/print values etc
                      },
                      style: const TextStyle(
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontSize: 14,
                        letterSpacing: -0.15,
                        height: 1,
                      ),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 14),
                          errorStyle: TextStyle(
                            fontSize: 17,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...replacementRequests.map((msg) {
            return FractionallySizedBox(
              widthFactor: 1.1,
              child: InkWell(
                onTap: () {
                  // Perform actions when the container is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatClassScreen(
                        appbartext: msg['ref'],
                        currentindex: 1,
                        replacementid: msg['rqid'],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    /*color: conversation.isActive 
                          ? const Color(0xFFF2F3F4) 
                          : Colors.white,*/
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFFCDD0D5),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                msg['ref'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(4, 19, 44, 1),
                                    letterSpacing: -0.44
                                    /*color: conversation.isActive 
                                        ? const Color(0xFF818995) 
                                        : const Color(0xFF04132C),*/
                                    ),
                              ),
                            ),
                            Expanded(
                              flex:
                                  2, // Takes 2 parts of the available space (twice as wide as Column 1)
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  msg['lastmessage'] != null
                                      ? Text(
                                          "Dernier message",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  129, 137, 149, 1),
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.44),
                                        )
                                      : Container(),
                                  msg['lastmessage'] != null
                                      ? Text(
                                          msg['lastmessage'],
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  129, 137, 149, 1),
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.44),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon2.svg',
                              height: 10,
                              width: 10,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "Du ${msg['beginDate']} au ${msg['endDate']}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(129, 137, 149, 1),
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ]);
      },
    );
  }
}
