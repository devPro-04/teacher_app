import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/widgets/conflictdialog.dart';
import 'package:olinom/widgets/sesssion_item.dart';

class ActionButtons extends StatelessWidget {
  late List<SessionItem> sessiondates;
  int replacementid;
  String ref;
  int levelid;

  ActionButtons({super.key, required this.sessiondates, required this.replacementid, required this.ref, required this.levelid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF005BFE), Color(0xFF0080FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showConflictDialog(context, sessiondates, replacementid, ref, levelid);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Accepter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: SizedBox(
              height: 46,
              child: OutlinedButton(
                onPressed: () {
                  
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF04132C),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Refuser',
                  style: TextStyle(
                    color: Color(0xFF04132C),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConflictDialog(BuildContext context, sessiondates, replacementid, ref, levelid) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return ConflictDialog(sessiondates: sessiondates, replacementid: replacementid, ref: ref, levelid: levelid,);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  
}



