import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/confirmdialog.dart';
import 'package:olinom/widgets/confirmrefusedialog.dart';
import 'package:olinom/widgets/sessiontile.dart';
import 'package:olinom/widgets/sesssion_item.dart';

class Refusedialog extends StatefulWidget {
  bool isconflict = false;
  int replacementid;
  String ref;
  int levelid;

  Refusedialog({super.key, required this.replacementid, required this.ref, required this.levelid});

  @override
  State<Refusedialog> createState() => _RefusedialogState();
}

class _RefusedialogState extends State<Refusedialog> {

  Future<void> _rejectMission() async {
    
    ApiConnection apiConnection = ApiConnection();
    bool accept = await apiConnection.rejectMission(
        widget.replacementid, widget.levelid);

    
    if (accept) {
      _showConfirmDialog(context, widget.ref);
    } else {
      showMySnackBar(
          message: "Unable to reject at the moment!",
          context: context,
          success: false);
      Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    return 
    
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
                    'Refuser cette mission ?',
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
                    'Cette mission sera définitivement retirée de votre liste et ne vous sera plus proposée.',
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
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 231, 234, 1),
                        borderRadius: BorderRadius.circular(8),
                        
                      ),
                      child: Text(
                        '#${widget.ref}',
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
                  Text(
                    "Vous pourrez continuer à consulter d'autres missions disponibles.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _rejectMission();
                            
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
                            'Refuser',
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

  void _showConfirmDialog(BuildContext context, ref) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return ConfirmRefuseDialog(ref:ref);
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