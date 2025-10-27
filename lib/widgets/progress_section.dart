import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:olinom/Models/mission_model.dart';

class ProgressSection extends StatelessWidget {
  MissionModel mission;
  double mprice;
  DateTime? rstartdate;
  DateTime? renddate;
  DateTime? firstdate;
  Color leftColor = Color.fromRGBO(253, 191, 0, 1);

  ProgressSection({super.key, required this.mission, required this.mprice});

  @override
  Widget build(BuildContext context) {
    
    return Container();
  }
}