import 'package:flutter/material.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/mission_details.dart';
import 'package:olinom/widgets/welcomemission.dart';

import '../Models/mission_model.dart';

class ApiMission extends StatefulWidget {
  const ApiMission({super.key});

  @override
  State<ApiMission> createState() => _ApiMissionState();
}

class _ApiMissionState extends State<ApiMission> {
  final apiConnection = ApiConnection();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MissionModel>>(
        future: apiConnection.getMissionsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF005BFE)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final missions = snapshot.data ?? [];
            // Build your ListView or other widgets to display the missions data
            return missions.isEmpty
                ? const Center(
                    child: Text(
                      'No missions available',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Column(
                children: [
                  ...missions.map((mission) {
                    // Create a Widget for each WelcomeMission
                    return WelcomeMission(mission, "mission"); // Example: A custom Widget
                  })
                  ]
                  );
          }
        },
      );
    
  }
}
