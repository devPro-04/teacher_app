import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/history_screen.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/screens/notification_screen.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/screens/profile_screen.dart';
import 'package:olinom/services/api_connection.dart';

class CustomOtherAppBar extends StatelessWidget implements PreferredSizeWidget {
    final List<Widget>? actions; // Optional actions for the app bar
    final _apiConnection = ApiConnection();
    final String appbartext;
    final _localStorage = LocalStorage();
    

    CustomOtherAppBar({
      required this.appbartext,
      super.key,
      this.actions,
    });

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height

    @override
    Widget build(BuildContext context) {
      int cindex = 0;
      if(appbartext == "Mission") {
        cindex = 1;
      }
      if(appbartext == "Sessions") {
        cindex = 2;
      }
      if(appbartext == "Messagerie") {
        cindex = 3;
      }
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(230, 231, 234, 1), // Color of the border
            width: 4.0,        // Thickness of the border
          ),
        ),
        flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Column (Left Side)
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // First Row in Left Column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print("customotherbar");
                          print(await _localStorage.getBacklink());
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
                          } else if(await _localStorage.getBacklink() == "session") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 2,),
                              ),
                            );
                          } else if(await _localStorage.getBacklink() == "messagerie") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 3,),
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
                          elevation: 0, // Removes the shadow/elevation
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Removes rounded corners
                          ),
                          side: const BorderSide(
                            width: 0, // Removes the border
                            color: Colors.transparent, // Makes the border transparent
                          ),
                          // You can also set other properties like backgroundColor, foregroundColor, padding, etc.
                          backgroundColor: Colors.white, // Example background color
                          foregroundColor: Colors.blue, // Example text color
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min, // To keep the row size minimal
                          children: [
                            Icon(Icons.arrow_back_ios, size: 20,),
                            SizedBox(width: 1.0), // Adjust spacing as needed
                            Text('Back'),
                            
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  
                  
                  // Second Row in Left Column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '${appbartext}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 20),
            
            // Second Column (Right Side)
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color.fromRGBO(230, 231, 234, 1),
                        width: 2,
                      )
                    ),
                    child: 
                      IconButton(
                        icon: Icon(Icons.notifications_outlined, color: Colors.black, size: 26,),
                        onPressed: () {
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(currentindex: 3),
                          ),
                        );
                        },
                      ),
                  ),
                  const SizedBox(width: 4),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color.fromRGBO(230, 231, 234, 1),
                        width: 2,
                      )
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/icon11.svg',
                          height: 20,
                          width: 20,
                        ),
                      onPressed: () {
                        if(appbartext == "Missions") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(redirectln: "Missions",),
                            ),
                          );
                        }
                        if(appbartext == "Sessions") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(redirectln: "Sessions",),
                            ),
                          );
                        }
                        if(appbartext == "Messagerie") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(redirectln: "Messagerie",),
                            ),
                          );
                        }
                        
                      },
                    ),
                  ),
                  
                  const SizedBox(width: 6)
                  

                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
  
}

