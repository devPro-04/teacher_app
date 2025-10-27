import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/sessiontile.dart';
import 'package:olinom/widgets/sesssion_item.dart';
import 'package:olinom/widgets/welcomemission.dart';

class AbsentConfirmDialog extends StatelessWidget {
  late SessionModel modal;
  bool isconflict = false;
  final _localStorage = LocalStorage();
  

  AbsentConfirmDialog({super.key, required this.modal});
  

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
                    'Absence confirmée',
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
                    '${modal.ref}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${modal.title}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${modal.startDate} - ${modal.endDate}',
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
                        color: Color.fromRGBO(230, 231, 234, 1),
                        borderRadius: BorderRadius.circular(8),
                        
                      ),
                      child: Text(
                        'Un remplaçant sera automatiquement recherché. Vous recevrez une notification si des actions supplémentaires sont nécessaires.',
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
                  
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            if(await _localStorage.getBacklink() == "mission") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(currentindex: 1,),
                                ),
                              );
                            } else if(await _localStorage.getBacklink() == "session") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(currentindex: 2,),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(currentindex: 0,),
                                ),
                              );
                            }
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
                            'Ok',
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
}