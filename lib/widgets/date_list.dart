import 'package:flutter/material.dart';
import 'package:olinom/services/time_converter.dart';
import 'package:olinom/widgets/custom_dates.dart';

class DateList extends StatelessWidget {
  final List<dynamic> startDate;
  final List<dynamic> endDate;
  int itemCount;
  DateList(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.itemCount});

  @override
  Widget build(BuildContext context) {
    TimeConverter timeConverter = TimeConverter();
    return ListView.builder(
        itemCount: itemCount < 3 ? itemCount : 3,
        itemBuilder: (context, index) {
          String startYear =
              timeConverter.time(curTime: startDate[index], isYear: true);
          String start =
              timeConverter.time(curTime: startDate[index], isYear: false);
          String end =
              timeConverter.time(curTime: endDate[index], isYear: false);
          return CustomDates(time: startYear, date: '$start à $end');
        });
  }
}
