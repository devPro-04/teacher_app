import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/detail_mission_screen.dart';
import '../Models/mission_model.dart';
import 'package:intl/intl.dart';
import 'package:olinom/widgets/refusedialog.dart';

class WelcomeMission extends StatelessWidget {
  MissionModel mission;
  String? redirectln;
  DateTime? rstartdate;
  DateTime? rstartdateToString;
  DateTime? renddate;
  DateTime? firstdate;
  Color leftColor = Color.fromRGBO(253, 191, 0, 1);

  WelcomeMission(this.mission, this.redirectln, {super.key});

  @override
  Widget build(BuildContext context) {
    print('Ato ' + mission.etat);
    if (mission.startDate != null) {
      rstartdate = DateFormat('dd MMMM yyyy').parse(mission.startDate!);
    }
    if (mission.endDate != null) {
      renddate = DateFormat('dd MMMM yyyy').parse(mission.endDate!);
    }
    if (mission.firstDate != null) {
      firstdate = DateFormat('dd MMMM yyyy HH:mm').parse(mission.firstDate!);
    }
    (mission.urgent == false)
        ? leftColor = Color.fromRGBO(0, 91, 254, 1)
        : leftColor = Color.fromRGBO(253, 191, 0, 1);
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 243, 244, 1),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(width: 4, color: leftColor)),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with tags
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 91, 254, 1)
                            .withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        mission.establishmentName,
                        style: const TextStyle(
                            color: Color.fromRGBO(204, 222, 255, 1),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    (mission.urgent == true)
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(253, 191, 0, 1)
                                  .withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'URGENT',
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 19, 44, 1),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.2),
                            ))
                        : Container(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  mission.ref,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44),
                ),
                const SizedBox(height: 4),
                Text(
                  mission.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(4, 19, 44, 1),
                  ),
                ),
                Text(
                  mission.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(4, 19, 44, 1),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    //Icon(Icons.school_outlined,
                    //    size: 16, color: Colors.grey[600]),
                    SvgPicture.asset(
                      'assets/icons/icon1.svg',
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      mission.levelName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(129, 137, 149, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon2.svg',
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${mission.sessions} Sessions',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 16),
                    SvgPicture.asset(
                      'assets/icons/icon3.svg',
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${mission.students} élèves',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Warning banner
          (mission.isAvailable == false)
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 90, 46, 0.35),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/icon4.svg',
                        height: 18,
                        width: 18,
                      ),
                      const Text(
                        'Conflit avec votre agenda détecté. Veuillez vérifier avant de valider',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(4, 19, 44, 1),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          // Price and details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distributes space evenly between children
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon5.svg',
                      height: 26,
                      width: 26,
                    ),
                    const Spacer(flex: 1),
                    Text(
                      '${mission.price}€',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(flex: 22),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon6.svg',
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Du ${DateFormat('dd/MM/yy').format(rstartdate!)} au ${DateFormat('dd/MM/yy').format(renddate!)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon7.svg',
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Premier cours: ${DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(firstdate!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(4, 19, 44, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Action buttons
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                (mission.isEnableAccept)
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMissionScreen(
                                      model: mission.replacementId,
                                      appbartext: "Détails de la mission",
                                      currentindex: 1,
                                      redirectln: redirectln!,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Accepter',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _showRefuseDialog(context);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: const BorderSide(
                                    color: Color.fromRGBO(4, 19, 44, 1),
                                    width: 2),
                              ),
                              child: Text(
                                'Refuser',
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 19, 44, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMissionScreen(
                          model: mission.replacementId,
                          appbartext: "Détails de la mission",
                          currentindex: 1,
                          redirectln: redirectln!,
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(
                        color: Color.fromRGBO(4, 19, 44, 1), width: 2),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Plus de détails',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRefuseDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Refusedialog(
          replacementid: mission.replacementId,
          levelid: mission.levelId,
          ref: mission.ref,
        );
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
