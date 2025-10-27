import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/Models/mission_model.dart';
import 'package:olinom/screens/details_mission.dart';

import '../screens/detail_mission_screen.dart';

class MissionDetails extends StatelessWidget {
  MissionModel model;

  MissionDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
              // model.urgent
              //     ? Colors.red
              //     :
              color: Color(0xFFE6E9F0), // Specify your desired color here
              width: 1
              // model.urgent ? 5 : 1, // Specify your desired border width here
              ),
          // bottom: BorderSide(
          //   color: Color(0xFFE6E9F0), // Specify your desired color here
          //   width: 1.0, // Specify your desired border width here
          // ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility(
          //   visible: model.urgent,
          //   child: Row(
          //     children: [
          //       SvgPicture.asset(
          //         'assets/icons/alert.svg',
          //       ),
          //       const Text(
          //         ' Mission urgente',
          //         style: TextStyle(
          //           color: Color(0xFFFF5A2E),
          //           fontSize: 14,
          //           fontWeight: FontWeight.w900,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Text(
            model.title,
            style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF005BFE)),
          ),
          Text(
            model.subject,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/sessions.svg',
                  ),
                  Text(
                    ' ${model.sessions} Session(s)',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/students.svg',
                  ),
                  Text(
                    ' ${model.students} Elèves',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Entre le ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black)),
              TextSpan(
                text: model.startDate,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF005BFE)),
              ),
              const TextSpan(
                  text: " et ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black)),
              TextSpan(
                text: model.endDate,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF005BFE)),
              ),
            ]),
          ),
          Text(
            'Première séance le ${model.startDate!}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/price.svg',
              ),
              Text(
                ' ${model.price}€',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          !model.urgent
              ? Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all<double>(0.0),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: const BorderSide(
                                color: Color(0xFF00102D),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        child:
                            const Text('Candidature en cours d’instruction')),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailMissionScreen(model: model),
                            ),
                          );*/
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(
                                  0xFF005BFE)), // Set the background color
                          elevation: WidgetStateProperty.all<double>(0.0),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the border radius here
                            ),
                          ),
                        ),
                        child: const Text(
                          'Accepter la mission',
                          style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsMission(model: model)));
                            },
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all<double>(0.0),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                    color: Color(0xFF00102D),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Détails de la mission',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00102D),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
