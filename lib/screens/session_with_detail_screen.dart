import 'package:flutter/material.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/widgets/session_details_without_button.dart';

class SessionWithDetailsScreen extends StatefulWidget {
  final SessionModel model;

  const SessionWithDetailsScreen({super.key, required this.model});

  @override
  State<SessionWithDetailsScreen> createState() => _SessionWithDetailsScreen();
}

class _SessionWithDetailsScreen extends State<SessionWithDetailsScreen> {
  late SessionModel mission;

  @override
  void initState() {
    super.initState();
    mission = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sessions",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SessionDetailsWithoutButtons(
            model: mission,
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Notes sur l’avancement',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  mission.note ?? "no notes",
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF8A9BBB)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
