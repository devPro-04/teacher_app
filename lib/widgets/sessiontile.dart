import 'package:flutter/material.dart';
import 'package:olinom/widgets/sesssion_item.dart';

class SessionTile extends StatelessWidget {
  final SessionItem session;
  int index;

  SessionTile({Key? key, required this.session, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    index = index + 1;
    return (session.isAvailable == false && session.isChecked == true)
    ?
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(242, 243, 244, 1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color.fromRGBO(205, 208, 213, 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session ${index}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  session.finalDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    : Container();
  }
}