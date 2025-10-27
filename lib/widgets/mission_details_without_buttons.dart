import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Models/mission_model.dart';

class MissionDetailsWithoutButtons extends StatelessWidget {
  MissionModel model;

  MissionDetailsWithoutButtons({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: model.urgent ? Colors.red : const Color(0xFFE6E9F0),
            width: model.urgent ? 5 : 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: model.urgent,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/alert.svg'),
                const Text(
                  ' Mission urgente',
                  style: TextStyle(
                    color: Color(0xFFFF5A2E),
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFF005BFE),
            ),
          ),
          Text(
            model.subject,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/students.svg'),
                  Text(
                    ' ${model.students} Elèves',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/price.svg'),
                  Text(
                    ' ${model.price}€',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
