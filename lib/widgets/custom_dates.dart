import 'package:flutter/material.dart';

class CustomDates extends StatelessWidget {
  const CustomDates(
      {super.key,
      this.enableDivider = true,
      required this.time,
      required this.date});
  final String date;
  final String time;
  final bool enableDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          if (enableDivider)
            const Divider(
              color: Colors.black12,
            ),
        ],
      ),
    );
  }
}
