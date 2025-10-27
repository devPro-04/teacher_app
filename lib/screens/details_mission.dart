import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/screens/date_details.dart';
import 'package:olinom/screens/detail_mission_screen.dart';
import 'package:olinom/screens/notes_details.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/date_list.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/widgets/mission_details_without_buttons.dart';

import '../Models/mission_model.dart';
import '../common/custom_snackbar.dart';

class DetailsMission extends StatefulWidget {
  final MissionModel model;
  const DetailsMission({super.key, required this.model});

  @override
  State<DetailsMission> createState() => _DetailsMissionState();
}

class _DetailsMissionState extends State<DetailsMission> {
  late MissionModel mission;
  ApiConnection apiConnection = ApiConnection();
  String missionNotes = ApiConnection.description;
  Map<String, List<dynamic>> dates = {
    'startDates': [],
    'endDates': [],
  };
  dynamic description;
  bool isLoading = true;
  bool isrejectLoading = false;

  @override
  void initState() {
    super.initState();
    mission = widget.model;
    _fetchMissionDates();
  }

  Future<void> _fetchMissionDates() async {
    try {
      var sessionDates = await apiConnection.getMission(mission.replacementId);
      setState(() {
        dates = {
          'startDates':
              sessionDates.map((date) => date['begindatetime']).toList(),
          'endDates': sessionDates.map((date) => date['enddatetime']).toList(),
        };
        print(dates['startDates']);
        isLoading = false;
        // missionNotes = ApiConnection.description;
      });
    } catch (e) {
      print('Error fetching mission dates: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _rejectMission() async {
    setState(() {
      isrejectLoading = true;
    });
    ApiConnection apiConnection = ApiConnection();
    bool accept = await apiConnection.rejectMission(
        mission.replacementId, mission.levelId);

    setState(() {
      isrejectLoading = false;
    });
    if (accept) {
      showMySnackBar(
          message: "Rejected the mission!", context: context, success: true);
    } else {
      showMySnackBar(
          message: "Unable to reject at the moment!",
          context: context,
          success: false);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Détails de la mission",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MissionDetailsWithoutButtons(
              model: mission,
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: const Color(0xFFE6E9F0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/dates.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Dates des sessions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: DateList(
                      startDate: dates['startDates']!,
                      endDate: dates['endDates']!,
                      itemCount: dates['endDates']!.length,
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DateDetails(
                            startDate: dates['startDates']!,
                            endDate: dates['endDates']!,
                            itemcount: dates['endDates']!.length)));
              },
              child: const Text('Voir toutes les dates',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: const Color(0xFFE6E9F0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/notes.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Notes sur l’avancement',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              child: Center(
                child: Text(
                  missionNotes.isEmpty ? 'No Notes' : missionNotes,
                  style: const TextStyle(color: Color(0xFF8A9BBB)),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                missionNotes.isEmpty
                    ? null
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotesDetails(note: missionNotes)));
              },
              child: const Text('Voir la note complète',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    buttonText: 'Accepter la mission',
                    onPressed: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailMissionScreen(model: mission)));*/
                    },
                    mainColor: const Color(0xFF005BFE),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainButton(
                    buttonText:
                        isrejectLoading ? 'rejecting..' : 'Refuser la mission',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Return the AlertDialog
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text(
                                'Are you sure you want to perform this action?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _rejectMission(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    mainColor: const Color(0xFFFDBF00),
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
