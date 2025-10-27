import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/screens/api_mission.dart';
import 'package:olinom/screens/message_screen.dart';
import 'package:olinom/screens/notification_screen.dart';
import 'package:olinom/screens/profile_screen.dart';
import 'package:olinom/screens/session_screen.dart';
import 'package:olinom/screens/splash_screen.dart';
import 'package:olinom/screens/welcome.dart';
import 'package:olinom/services/api_connection.dart';

import '../Models/mission_model.dart';
import '../widgets/custom_tabbar.dart';
import 'package:olinom/widgets/appbar.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:olinom/widgets/customotherbar.dart';

class HomeScreen extends StatefulWidget {
  final int currentindex;

  const HomeScreen({required this.currentindex, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appBarText = '';
  int _selectedIndex = 0;
  late CustomTabbar customTabbar;
  final _localStorage = LocalStorage();
  bool hasUnreadNotifications = false;
  bool hasUnreadMessages = false;

  late List<MissionModel> missionsFuture;

  @override
  initState() {
    _checkInternetConnection();
    _selectedIndex = widget.currentindex;
    _checkUnreadNotifications();
    _checkUnreadMessages();

    switch (widget.currentindex) {
      case 0:
        appBarText = "Welcome";
        break;
      case 1:
        appBarText = "Missions";
        break;
      case 2:
        appBarText = "Sessions";
        break;
      case 3:
        appBarText = "Messagerie";
        break;
    }
    //_localStorage.saveBacklink("welcome");
    super.initState();
  }

  Future<void> _checkUnreadNotifications() async {
    // Ici, vous devrez implémenter la logique pour vérifier les notifications
    // Par exemple, appeler votre API ou vérifier le stockage local

    // Exemple temporaire - à remplacer par votre logique réelle
    final hasUnread = await _checkForUnreadNotificationsFromAPI();

    setState(() {
      hasUnreadNotifications = hasUnread;
    });
  }

  Future<void> _checkUnreadMessages() async {
    // La logique réelle pour vérifier les messages non lus doit être implémentée ici.
    // Par exemple, appeler une API ou vérifier le stockage local.
    final hasUnread = await _checkForUnreadMessagesFromAPI();

    setState(() {
      hasUnreadMessages = hasUnread;
    });
  }

  Future<bool> _checkForUnreadMessagesFromAPI() async {
    try {
      // TODO: Implémentez l'appel API réel ici.
      // return await apiConnection.hasUnreadMessages();

      // Pour l'exemple, retourne false par défaut.
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkForUnreadNotificationsFromAPI() async {
    try {
      // Exemple : appel API pour vérifier les notifications non lues
      // return await apiConnection.hasUnreadNotifications();

      // Pour l'exemple, on retourne true pour tester
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _checkInternetConnection() async {
    final _localStorage = LocalStorage();
    _localStorage.saveBacklink("welcome");
    var jwtToken = await _localStorage.getJwtToken();
    if (jwtToken != null) {
      bool hasExpired = JwtDecoder.isExpired(jwtToken!);
      if (hasExpired == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
  }

  final apiConnection = ApiConnection();
  final List<Widget> _widgetOptions = <Widget>[
    const WelcomeScreen(),
    const ApiMission(),
    const SessionScreen(),
    const MessageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 0,
              ),
            ),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 1,
              ),
            ),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 2,
              ),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                currentindex: 3,
              ),
            ),
          );
          break;
      }
    });
  }

  // Future<void> _checkUnreadMessages() async {
  //   // La logique réelle pour vérifier les messages non lus doit être implémentée ici.
  //   // Par exemple, appeler une API ou vérifier le stockage local.
  //   final hasUnread = await _checkForUnreadMessagesFromAPI();

  //   setState(() {
  //     hasUnreadMessages = hasUnread;
  //   });
  // }

  // Future<bool> _checkForUnreadMessagesFromAPI() async {
  //   try {
  //     // TODO: Implémentez l'appel API réel ici.
  //     // return await apiConnection.hasUnreadMessages();

  //     // Pour l'exemple, retourne false par défaut.
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (_selectedIndex == 1 ||
              _selectedIndex == 2 ||
              _selectedIndex == 3)
          ? PreferredSize(
              preferredSize:
                  const Size.fromHeight(100.0), // Define the preferred height
              child: CustomOtherAppBar(appbartext: appBarText))
          : PreferredSize(
              preferredSize:
                  const Size.fromHeight(70.0), // Define the preferred height
              child: CustomAppBar(),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Padding(
              padding: const EdgeInsets.all(5.0),
              child: _widgetOptions.elementAt(_selectedIndex),
            ),*/
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
              color: _selectedIndex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/welcomeactive.svg',
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/mission.svg',
              color: _selectedIndex == 0 ? null : Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/missionactive.svg',
            ),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/session.svg',
              color: _selectedIndex == 0 ? null : Colors.grey,
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
                  color: _selectedIndex == 0 ? null : Colors.grey,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          hasUnreadMessages ? Colors.blue : Colors.transparent,
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
                      color:
                          hasUnreadMessages ? Colors.blue : Colors.transparent,
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
