import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/absentconfirmdialog.dart';
import 'package:olinom/widgets/sessiontile.dart';
import 'package:olinom/widgets/sesssion_item.dart';
import 'package:olinom/widgets/welcomemission.dart';

class AbsentDialog extends StatefulWidget {
  late SessionModel modal;
  int? sessionid;
  String reason;

  AbsentDialog({super.key, required this.modal, required this.sessionid, required this.reason});

  @override
  State<AbsentDialog> createState() => _AbsentDialogState();
}
  
class _AbsentDialogState extends State<AbsentDialog> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> _cancelSession(int sessionid, String reason) async {
    
    ApiConnection apiConnection = ApiConnection();
    bool accept = await apiConnection.rejectSession(sessionid, reason);
    

    if (accept) {
      _showAbsentConfirmDialog(context);
    } else {
      showMySnackBar(
          message: "Unable to apply at the moment!",
          context: context,
          success: false);
      Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
                    'Se déclarer absent',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  
                  // Description
                  Text(
                    '${widget.modal.ref}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.modal.title}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.modal.startDate} - ${widget.modal.endDate}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  
                  // Confirmation text
                  
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 90, 46, 0.35),
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    child: Text(
                      'Des absences répétées peuvent affecter votre statut et entraîner la désactivation de votre compte',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.44
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _cancelSession(widget.sessionid!, widget.reason);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(255, 90, 46, 1),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Confirmer mon absence',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              
                            ),
                            elevation: 0,
                            side: BorderSide(color: Color.fromRGBO(4, 19, 44, 1), width: 2),
                          ),
                          child: Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
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

  void _showAbsentConfirmDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return AbsentConfirmDialog(modal: widget.modal);
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