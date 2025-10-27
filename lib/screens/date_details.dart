import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/widgets/date_list.dart';

class DateDetails extends StatelessWidget {
  final startDate;
  final endDate;
  final int itemcount;
  const DateDetails(
      {super.key,
      required,
      required this.startDate,
      required this.endDate,
      required this.itemcount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Détails de la mission",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset('assets/icons/dates.svg'),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Dates des sessions',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Expanded(
              child: DateList(
                  startDate: startDate, endDate: endDate, itemCount: itemcount))
        ],
      ),
    );
  }
}
