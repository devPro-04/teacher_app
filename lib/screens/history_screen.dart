import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/mission_history.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/widgets/detailbar.dart';


class HistoryScreen extends StatefulWidget {
  String redirectln;

  HistoryScreen({
    super.key,
    required this.redirectln
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final String appbartext;
  late final int currentindex;
  ApiConnection apiConnection = ApiConnection();
  final _localStorage = LocalStorage();
  

  @override
  void initState() {
    super.initState();
    appbartext = 'Historique';
    currentindex = 1;
    if(widget.redirectln == "Missions") {
      _localStorage.saveBacklink("mission");
    }
    if(widget.redirectln == "Sessions") {
      _localStorage.saveBacklink("session");
    }
    if(widget.redirectln == "Notification") {
      _localStorage.saveBacklink("notification");
    }
  }

  Future<Map<String, dynamic>> _fetchMissionHistory() async {
    try {
      
      final results = await Future.wait([
        apiConnection.getMissionHistory()
      ]);
      
      return {
        'histories': results[0] as List<MissionHistory>
      };
      
    } catch (e, stackTrace) {
      print('DETAILED ERROR in _fetchMissionDates:');
      print('Error type: ${e.runtimeType}');
      print('Error message: $e');
      print('Stack trace: $stackTrace');
      
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
        future: _fetchMissionHistory(),
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
          final histories = data['histories'];
          

          return SafeArea(
            //padding: const EdgeInsets.all(16),
            child: 
              Column(
              children: [ 
                Expanded(
              child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: histories.length,
              itemBuilder: (context, index) {
                final item = histories[index];
                Color statuscolor = Color.fromRGBO(0,91,254,1);
                Color textcolor = Color.fromRGBO(4,19,44,1);
                if(item.etat == "ACCEPTEE") {
                  statuscolor = Color.fromRGBO(0,91,254,1);
                  textcolor = Color.fromRGBO(204,222,255,1);
                } else if(item.etat == "ANNULEE") {
                  statuscolor = Color.fromRGBO(255,90,46,1);
                } else {
                  statuscolor = Color.fromRGBO(253,191,0,1);
                }
                String price = '';
                if(item.price != 0) {
                  price = '${item.ref} - ${item.price}€';
                } else {
                  price = '${item.ref}';
                }
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F4),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                      left: BorderSide(
                        color: statuscolor,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: statuscolor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            item.etat,
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: textcolor,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.beginDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF04132C),
                            letterSpacing: -0.44,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF04132C),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              ),
                ),
              ]
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
