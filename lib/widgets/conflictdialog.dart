import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/confirmdialog.dart';
import 'package:olinom/widgets/sessiontile.dart';
import 'package:olinom/widgets/sesssion_item.dart';

class ConflictDialog extends StatefulWidget {
  late List<SessionItem> sessiondates;
  bool isconflict = false;
  int replacementid;
  String ref;
  int levelid;

  ConflictDialog({super.key, required this.sessiondates, required this.replacementid, required this.ref, required this.levelid});

  @override
  State<ConflictDialog> createState() => _ConflictDialogState();
}

class _ConflictDialogState extends State<ConflictDialog> {

  Future<void> _confirmMission() async {
    List<dynamic> sessionids = [];
    for (SessionItem sessiondate in widget.sessiondates) {
      if(sessiondate.isChecked == true) {
        sessionids.add(sessiondate.sessionId);
      }
    }

    if(sessionids.isNotEmpty) {
      
      ApiConnection apiConnection = ApiConnection();
      bool accept = await apiConnection.acceptMission(
          widget.replacementid, widget.levelid, sessionids);

      

      if (accept) {
        _showConfirmDialog(context, widget.sessiondates, widget.replacementid, widget.ref);
      } else {
        showMySnackBar(
            message: "Unable to apply at the moment!",
            context: context,
            success: false);
        Navigator.pop(context);
      }
    } else {
      showMySnackBar(
            message: "Please select atleast one session",
            context: context,
            success: false);
        Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    for (SessionItem sessiondate in widget.sessiondates) {
      if(sessiondate.isAvailable == false && sessiondate.isChecked == true) {
        widget.isconflict = true;
        break;
      }
    }
    return 
    (widget.isconflict)
    ?
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning icon and title
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/icon16.svg',
                        height: 16,
                        width: 16,
                      
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Title
                  Text(
                    'Confirmer avec les conflits',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  
                  // Description
                  Text(
                    'Vous êtes sur le point de confirmer votre souhait d\'assurer ces sessions malgré les conflits avec votre planning.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  
                  // Confirmation text
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'En confirmant vous confirmez pouvoir vous réorganiser et assurer ces cours.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.44
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  // Sessions list
                  Container(
                    constraints: BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.sessiondates.length,
                      
                      itemBuilder: (context, index) {
                        return SessionTile(session: widget.sessiondates[index], index: index);
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _confirmMission();
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 91, 254, 1),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Accepter la mission',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            'Revoir ma sélection',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: -0.44
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
    :
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning icon and title
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/icon17.svg',
                        height: 16,
                        width: 16,
                      
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Title
                  Text(
                    'Confirmer la mission',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  
                  // Description
                  Text(
                    'Vous êtes sur le point d’accepter la mission de remplacement',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2),
                  
                  // Confirmation text
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Dès que l’établissement aura validé votre profil, vous recevrez une confirmation.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.44
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Souhaitez-vous confirmer?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.44
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 14),
                  
                  // Action buttons
                  Row(
                    children: [
                      
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: -0.44
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _confirmMission();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 91, 254, 1),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Je confirmer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, sessiondates, replacementid, ref) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return ConfirmDialog(sessiondates: sessiondates, replacementid: replacementid, ref:ref);
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