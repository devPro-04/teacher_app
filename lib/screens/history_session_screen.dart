import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/screens/home_screen.dart';
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

class HistorySessionScreen extends StatefulWidget {
  SessionModel session;
  final int replacementid;
  final String appbartext;
  final int currentindex;

  HistorySessionScreen({
    super.key, 
    required this.session,
    required this.replacementid,
    required this.appbartext,
    required this.currentindex
  });

  @override
  State<HistorySessionScreen> createState() => _HistorySessionScreenState();
}

class _HistorySessionScreenState extends State<HistorySessionScreen> {
  late final String appbartext;
  late final int currentindex;
  ApiConnection apiConnection = ApiConnection();
  final _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
    appbartext = widget.appbartext;
    currentindex = widget.currentindex;
    _localStorage.saveBacklink("sessiondetail");
  }

  Future<Map<String, dynamic>> _fetchReport() async {
    try {
     
      final results = await Future.wait([
        apiConnection.getSessionReports(widget.replacementid),
        
      ]);
      
      return {
        'sessionreport': results[0],
        
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
      backgroundColor: Colors.white,
      appBar: 
        PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Define the preferred height
          child: DetailAppBar(appbartext: appbartext, index: currentindex,),
        ),
      body: 

      FutureBuilder<Map<String, dynamic>>(
        future: _fetchReport(),
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
          final sessionreport = data['sessionreport'];
          
          var index = 0;
          
         
          

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(230, 239, 255, 1),
                  ),
                  padding: const EdgeInsets.only(left: 162,top: 24,right: 160, bottom: 24),  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: 
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with badge and progress
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF005BFE),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.session.establishmentName!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/sessions.svg',
                                    height: 14,
                                    width: 14,
                                    
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${widget.session.sessionnumber}/${widget.session.totalsession}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 91, 254, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          
                          // Session details
                          Text(
                            widget.session.ref!,
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.session.title!,
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.session.subject!,
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 19, 44, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.44,
                            ),
                          ),
                          const SizedBox(height: 6),
                          
                          // Level info
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon1.svg',
                                height: 10,
                                width: 10,
                                
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.session.levelname!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(129, 137, 149, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          
                          // Students and duration
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/icon3.svg',
                                    height: 10,
                                    width: 10,
                                    
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${widget.session.student} élèves',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(129, 137, 149, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.4
                                    ),
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                          const SizedBox(height: 6),
                          
                          // Date and time
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon10.svg',
                                height: 14,
                                width: 14,
                                
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${widget.session.startDate} - ${widget.session.endDate}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: TextStyle(
                                    color: Color.fromRGBO(4, 19, 44, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.4
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
                const SizedBox(height: 16),
                ...sessionreport.map((sess){
                  return FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(12, 18, 14, 18),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 243, 244, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border(
                          left: BorderSide(color: Color.fromRGBO(129, 137, 149, 1), width: 4),
                        ),
                      ),
                      child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Session du ${sess['sessiondate']}',
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 19, 44, 1),
                                fontSize: 16,
                                letterSpacing: -0.44,
                                fontWeight: FontWeight.w700,
                              ),
                              
                            ),
                            Text(
                              '${sess['report']}',
                              style: const TextStyle(
                                color: Color.fromRGBO(129, 137, 149, 1),
                                fontSize: 14,
                                letterSpacing: -0.60,
                                height: 1.57, // line-height: 22px / font-size: 14px
                              ),
                              maxLines: 13,
                              overflow: TextOverflow.ellipsis,
                            ) 
                          ]
                        ),  
                    ),
                  );
                })
                    
                    
                
              ],
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
