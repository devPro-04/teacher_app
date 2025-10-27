import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/screens/welcome.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/welcomemission.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
    final List<Widget>? actions; // Optional actions for the app bar
    final _apiConnection = ApiConnection();
    final String appbartext;
    final int index;
    final _localStorage = LocalStorage();
    

    DetailAppBar({
      required this.appbartext,
      required this.index,
      super.key,
      this.actions,
    });

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height

    @override
    Widget build(BuildContext context) {
      
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(253, 191, 0, 1), // Color of the border
            width: 6.0,        // Thickness of the border
          ),
        ),
        flexibleSpace: 
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Expanded(
                flex: 1,
                child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print("detailbar");
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
                          } else if(await _localStorage.getBacklink() == "sessiondetail") {
                            Navigator.of(context).pop();
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
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min, // To keep the row size minimal
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_back_ios, size: 20,),
                            SizedBox(width: 1.0), // Adjust spacing as needed
                            Text('Back'),
                            
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: 
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${appbartext}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.43,
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            )
          )  
      );
  }
  
}

