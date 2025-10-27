import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/sessiontile.dart';
import 'package:olinom/widgets/sesssion_item.dart';
import 'package:olinom/widgets/welcomemission.dart';

class ConfirmDialog extends StatelessWidget {
  late List<SessionItem> sessiondates;
  bool isconflict = false;
  int replacementid;
  String ref;
  final _localStorage = LocalStorage();

  ConfirmDialog({super.key, required this.sessiondates, required this.replacementid, required this.ref});
  

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
                      'assets/icons/icon18.svg',
                        height: 16,
                        width: 16,
                      
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Title
                  Text(
                    'Mission acceptée',
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
                    'Nous présentons votre candidature à l’établissement.',
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
                        '#${ref}',
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
                  
                  Text(
                    'Nous présentons votre candidature à l’établissement.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.44
                    ),
                    textAlign: TextAlign.center,
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
                            } else if(await _localStorage.getBacklink() == "welcome") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(currentindex: 0,),
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
                            'Compris',
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