import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/Models/session_model.dart';

import '../services/time_converter.dart';

class SessionDetailsWithoutButtons extends StatelessWidget {
  SessionModel model;

  SessionDetailsWithoutButtons({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    TimeConverter converter = TimeConverter();
    String starttime = converter.time(curTime: model.starTime);
    String endtime = converter.time(curTime: model.endTime);
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        // color: model.current! ? const Color(0xFFE6EFFF) : Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE6E9F0), // Specify your desired color here
            width: 1, // Specify your desired border width here
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: model.current!,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFF005BFE),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Prochaine session',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            model.title!,
            style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF005BFE)),
          ),
          Text(
            model.startDate!,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Text(
            model.subject!,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/sessions.svg',
                  ),
                  Text(
                    ' ${model.session}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/time.svg',
                  ),
                  Text(
                    ' $starttime à $endtime',
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
            height: 10,
          ),
        ],
      ),
    );
  }
}
