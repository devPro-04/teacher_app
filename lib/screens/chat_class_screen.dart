import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/screens/chat_screen.dart';
import 'package:olinom/screens/history_session_screen.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/screens/progress_session_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/action_buttons.dart';
import 'package:olinom/widgets/detailbar.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/widgets/mission_accordion.dart';
import 'package:olinom/widgets/mission_details_without_buttons.dart';
import 'package:olinom/widgets/progress_section.dart';
import 'package:olinom/widgets/session_list.dart';
import 'package:olinom/widgets/sesssion_item.dart';

import '../Models/mission_model.dart';

class ChatClassScreen extends StatefulWidget {
  final int replacementid;
  final String appbartext;
  final int currentindex;

  const ChatClassScreen({
    super.key, 
    required this.replacementid,
    required this.appbartext,
    required this.currentindex
  });

  @override
  State<ChatClassScreen> createState() => _ChatClassScreenState();
}

class _ChatClassScreenState extends State<ChatClassScreen> {
  late final String appbartext;
  int currentindex = 3;
  ApiConnection apiConnection = ApiConnection();
  final _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
    appbartext = widget.appbartext;
    currentindex = widget.currentindex;
    _localStorage.saveBacklink("messagerie");
  }

  Future<dynamic> _fetchClasses() async {
    try {
     
      final results = await Future.wait([
        apiConnection.getMessageClasses(widget.replacementid)
        
      ]);
      
      return {
        'messageClasses': results[0],
        
      };
      
    } catch (e, stackTrace) {

      // Re-throw to let FutureBuilder handle it
      rethrow;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      currentindex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(currentindex: 0,),
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(currentindex: 1,),
            ),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(currentindex: 2,),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(currentindex: 3,),
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 243, 244, 1),
      appBar: 
        PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Define the preferred height
          child: DetailAppBar(appbartext: appbartext, index: currentindex,),
        ),
      body: 

      FutureBuilder<dynamic>(
        future: _fetchClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 64),
                  SizedBox(height: 16),
                  Text('Error1: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => setState(() {}), // Rebuild to retry
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          final messageClasses = data['messageClasses']['replacements'];
          print("$messageClasses");
          var index = 0;
          
         
          

          return SingleChildScrollView(
            
            child: 
            InkWell(
              onTap: () {
                // Perform actions when the container is tapped
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(appbartext: messageClasses['title'], currentindex: 1, replacementid: messageClasses['repid'],),
                      ),
                    );
              },
              child:
              Container(
                margin: const EdgeInsets.fromLTRB(16, 24, 24, 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE6E7EA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (messageClasses['unreadCount'] != 0) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0x59FF5A2E),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.message,
                              size: 12,
                              color: Color(0xFF04132C),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${messageClasses['unreadCount']} Messages non lus',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF04132C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messageClasses['title'] ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF04132C),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          messageClasses['subjname'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF04132C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.school,
                                  size: 14,
                                  color: Color(0xFF818995),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  messageClasses['levelname'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF818995),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  size: 14,
                                  color: Color(0xFF818995),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  messageClasses['students'].toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF818995),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/welcome.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/welcomeactive.svg',
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/mission.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/missionactive.svg',
            ),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/session.svg',
              color: currentindex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/sessionactive.svg',
            ),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/message.svg',
                  color: currentindex == 0 ? null : Colors.grey,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/messageactive.svg',
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Messagerie',
          ),
        ],
      ),
    );
  }
}
