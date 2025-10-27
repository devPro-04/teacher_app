import 'package:flutter/material.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/widgets/session_details_without_button.dart';

import '../common/custom_snackbar.dart';
import '../services/api_connection.dart';

class SessionDetailsScreen extends StatefulWidget {
  final SessionModel model;

  const SessionDetailsScreen({super.key, required this.model});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreen();
}

class _SessionDetailsScreen extends State<SessionDetailsScreen> {
  late SessionModel mission;
  final TextEditingController _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    mission = widget.model;
  }

  Future<void> _cancelSession(int sessionid, String reason) async {
    setState(() {
      isLoading = true;
    });
    ApiConnection apiConnection = ApiConnection();
    bool accept = await apiConnection.rejectSession(sessionid, reason);
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
      body: Form(
        key: _formKey,
        child: Column(
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
                'Raison de l’annulation*',
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
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Déclarer une raison";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Color(0xFF8A9BBB)),
                    controller: _reasonController,
                    maxLines: 10, // Allows the text field to expand vertically
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Color(0xFF8A9BBB)),
                      hintText:
                          'Orci commodo libero montes velit quis etiam magna nisi. Amet pellentesque feugiat sapien nisl in volutpat. Mauris purus ultrices proin ornare tempus mi proin rhoncus. A mauris quam odio magna amet sit amet massa dictum. Sit et nisl massa ipsum. Sed venenatis aliquet rhoncus diam.',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(
                buttonText: isLoading ? "Loading" : 'Confirmer l’absence',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _cancelSession(mission.sessionid!, _reasonController.text);
                  }
                },
                mainColor: const Color(0xFFFF5A2E),
              ),
            )
          ],
        ),
      ),
    );
  }
}
