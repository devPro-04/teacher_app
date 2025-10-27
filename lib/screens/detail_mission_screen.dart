import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/action_buttons.dart';
import 'package:olinom/widgets/detailbar.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/widgets/mission_accordion.dart';
import 'package:olinom/widgets/mission_details_without_buttons.dart';
import 'package:olinom/widgets/progress_section.dart';
import 'package:olinom/widgets/session_list.dart';
import 'package:olinom/widgets/sesssion_item.dart';

import '../Models/mission_model.dart';

class DetailMissionScreen extends StatefulWidget {
  final int model;
  final String appbartext;
  final int currentindex;
  String redirectln;

  DetailMissionScreen(
      {super.key,
      required this.model,
      required this.appbartext,
      required this.currentindex,
      required this.redirectln});

  @override
  State<DetailMissionScreen> createState() => _DetailMissionScreenState();
}

String formatDateEnFrancais(DateTime date) {
  final format = DateFormat('dd MMMM yyyy', 'fr_FR');
  return format.format(date);
}

class _DetailMissionScreenState extends State<DetailMissionScreen> {
  late final String appbartext;
  int currentindex = 0;
  ApiConnection apiConnection = ApiConnection();
  late List<SessionItem> sessiondates;
  final _localStorage = LocalStorage();
  List<int> selectedSessions = [];
  double missionprice = 0;
  late int isfirst;

  @override
  void initState() {
    super.initState();
    appbartext = widget.appbartext;
    currentindex = widget.currentindex;
    print("redirectln");
    print(widget.redirectln);
    if (widget.redirectln == "mission") {
      _localStorage.saveBacklink("mission");
    }
    if (widget.redirectln == "welcome") {
      _localStorage.saveBacklink("welcome");
    }
    print("localstorage");
    print(_localStorage.getBacklink());
    isfirst = 0;
  }

  Future<Map<String, dynamic>> _fetchMissionDates() async {
    try {
      final results = await Future.wait([
        apiConnection.getOneMission(widget.model),
        apiConnection.getOneMissionSessionDates(widget.model)
      ]);

      if (isfirst == 0) {
        final sdates = results[1] as List<SessionItem>;
        sdates.forEach((sd) {
          SessionItem sessiondatess = sd;
          if (sessiondatess.isChecked) {
            selectedSessions.add(sessiondatess.sessionId);
          }
        });
      }

      return {
        'mission': results[0],
        'sessiondates': results[1] as List<SessionItem>,
      };
    } catch (e, stackTrace) {
      // Re-throw to let FutureBuilder handle it
      rethrow;
    }
  }

  Future<void> updateprice(
      List<int> sessions, int idlevel, int idreplacement) async {
    try {
      int priceprof = 0;
      String isProfIsProfEtab = "/";
      final results = await Future.wait([
        apiConnection.updatepricereplacement(
            sessions, priceprof, idlevel, idreplacement, isProfIsProfEtab),
      ]);

      final data = results[0];
      print("latest price");
      print(data['price']);
      setState(() {
        isfirst = 1;
        missionprice = data['price'].toDouble();
        selectedSessions = sessions;
      });
    } catch (e, stackTrace) {
      // Re-throw to let FutureBuilder handle it
      rethrow;
    }
  }

  /*Future<void> _confirmMission() async {
    setState(() {
      isLoading = true;
    });
    ApiConnection apiConnection = ApiConnection();
    bool accept = await apiConnection.acceptMission(
        mission!.replacementId, mission!.levelId);

    setState(() {
      isLoading = false;
    });

    if (accept) {
      showMySnackBar(
          message: "Successfully applied!", context: context, success: true);
    } else {
      showMySnackBar(
          message: "Unable to apply at the moment!",
          context: context,
          success: false);
    }
    Navigator.pop(context);
  }*/

  void _onItemTapped(int index) {
    setState(() {
      currentindex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 0,
              ),
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 1,
              ),
            ),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 2,
              ),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 3,
              ),
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80.0), // Define the preferred height
        child: DetailAppBar(
          appbartext: appbartext,
          index: currentindex,
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchMissionDates(),
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
            final mission = data['mission'];
            //missionprice = mission.price;
            if (mission.isEnableAccept) {
              sessiondates = data['sessiondates'];
            } else {
              sessiondates = [];
            }
            var index = 0;
            print("selectedsessionslist");
            print(selectedSessions);
            if (isfirst == 0) {
              updateprice(
                  selectedSessions, mission.levelId, mission.replacementId);
            }
            print("afterstate");
            print(missionprice);
            DateTime? rstartdate;
            DateTime? renddate;
            DateTime? firstdate;
            Color leftColor = Color.fromRGBO(253, 191, 0, 1);
            if (mission.startDate != null) {
              rstartdate = DateFormat('dd MMMM yyyy').parse(mission.startDate!);
            }
            if (mission.endDate != null) {
              renddate = DateFormat('dd MMMM yyyy').parse(mission.endDate!);
            }
            if (mission.firstDate != null) {
              firstdate =
                  DateFormat('dd MMMM yyyy HH:mm').parse(mission.firstDate!);
            }
            (mission.urgent == false)
                ? leftColor = Color.fromRGBO(0, 91, 254, 1)
                : leftColor = Color.fromRGBO(253, 191, 0, 1);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 366),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badges
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF005BFE),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                mission.establishmentName,
                                style: TextStyle(
                                  color: Color(0xFFCCDEFF),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            (mission.urgent == true)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFDBF00),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'URGENT',
                                      style: TextStyle(
                                        color: Color(0xFF04132C),
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Mission ID
                        Text(
                          mission.ref,
                          style: TextStyle(
                            color: Color(0xFF04132C),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Title and Subject
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                color: Color(0xFF04132C),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              mission.subject,
                              style: TextStyle(
                                color: Color(0xFF04132C),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Education level
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon1.svg',
                              height: 14,
                              width: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              mission.levelName,
                              style: const TextStyle(
                                color: Color(0xFF818995),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Sessions and students info
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/icon2.svg',
                                  height: 14,
                                  width: 14,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${mission.sessions} Sessions',
                                  style: TextStyle(
                                    color: Color(0xFF818995),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/icon3.svg',
                                  height: 14,
                                  width: 14,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${mission.students} élèves',
                                  style: TextStyle(
                                    color: Color(0xFF818995),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Warning card
                        (mission.isAvailable == false)
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 90, 46, 0.35),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red[200]!),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/icons/icon4.svg',
                                      height: 18,
                                      width: 18,
                                    ),
                                    const Text(
                                      'Conflit avec votre agenda détecté. Veuillez vérifier avant de valider',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(4, 19, 44, 1),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 16),
                        // Price
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon5.svg',
                              height: 26,
                              width: 26,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${missionprice}€',
                              style: TextStyle(
                                color: Color(0xFF04132C),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Date range
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon6.svg',
                              height: 14,
                              width: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Du ${DateFormat('dd/MM/yy').format(rstartdate!)} au ${DateFormat('dd/MM/yy').format(renddate!)}',
                              style: TextStyle(
                                color: Color(0xFF04132C),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // First course info
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon7.svg',
                              height: 14,
                              width: 14,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                // 'Premier cours: ${mission.firstDate}',
                                'Premier cours: ${DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(mission.firstDate)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(4, 19, 44, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  MissionAccordion(
                    mission: mission,
                  ),
                  (sessiondates.isNotEmpty)
                      ? FractionallySizedBox(
                          widthFactor: 2.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(242, 247, 255, 1),
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(205, 208, 213, 1))),
                            ),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsetsGeometry.directional(
                                  start: 179),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/icon14.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Dates des sessions',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(4, 19, 44, 1),
                                        letterSpacing: -0.44),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  ...sessiondates.map((sessiondates) {
                    // Create a Widget for each WelcomeMission
                    index = index + 1;
                    return SessionList(
                        sessiondates: sessiondates,
                        index: index,
                        replacementid: mission.replacementId,
                        updateprice: updateprice,
                        levelid: mission.levelId,
                        selectedNumbers:
                            selectedSessions); // Example: A custom Widget
                  }).toList(),
                  (mission.isEnableAccept)
                      ? const SizedBox(height: 24)
                      : Container(),
                  (mission.isEnableAccept)
                      ? ActionButtons(
                          sessiondates: sessiondates,
                          replacementid: mission.replacementId,
                          ref: mission.ref,
                          levelid: mission.levelId,
                        )
                      : Container(),
                ],
              ),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/welcome.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/welcomeactive.svg',
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/mission.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/missionactive.svg',
            ),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/session.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/sessionactive.svg',
            ),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/message.svg',
                  color: currentindex == 0 ? null : Colors.grey,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/messageactive.svg',
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Messagerie',
          ),
        ],
      ),
    );
  }
}
