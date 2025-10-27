import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/absentdialog.dart';
import 'package:olinom/widgets/appbar.dart';
import 'package:olinom/widgets/custom_tabbar.dart';
import 'package:olinom/widgets/customotherbar.dart';
import 'package:olinom/widgets/session_details.dart';

class SessionabsentScreen extends StatefulWidget {
  SessionModel model;

  SessionabsentScreen({super.key, required this.model});

  @override
  State<SessionabsentScreen> createState() => _SessionabsentScreenState();
}

class _SessionabsentScreenState extends State<SessionabsentScreen> {
  final apiConnection = ApiConnection();
  String appBarText = 'Sessions';
  int _selectedIndex = 2;
  late CustomTabbar customTabbar;
  final TextEditingController _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _reasonController.text = "";
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    double topInset = MediaQuery.of(context).padding.top;
    double visibleScreenHeight = screenHeight - bottomInset - topInset;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: 
        
        PreferredSize(
          preferredSize: const Size.fromHeight(100.0), // Define the preferred height
          child: 
             CustomOtherAppBar(appbartext: appBarText)
        ),
        
      body: 
        Form(
        key: _formKey,
        child: 
        SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F4),
            borderRadius: BorderRadius.circular(6),
            border: const Border(
              left: BorderSide(
                color: Color(0xFF005BFE),
                width: 4,
              ),
            ),
          ),
          height: visibleScreenHeight,
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
          child: 
            
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 91, 254, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${widget.model.establishmentName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/sessions.svg',
                          height: 14,
                          width: 14,
                          
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.model.sessionnumber}/${widget.model.totalsession}',
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 91, 254, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Session Details
              Text(
                '${widget.model.ref}',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 19, 44, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.44,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.model.title}',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 19, 44, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.44,
                ),
              ),
              Text(
                '${widget.model.subject}',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 19, 44, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.44,
                ),
              ),
              const SizedBox(height: 8),
              // Level Info
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon1.svg',
                    height: 10,
                    width: 10,
                    
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.model.levelname}',
                    style: const TextStyle(
                      color: Color.fromRGBO(129, 137, 149, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 8),
              // Students and Duration
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon3.svg',
                    height: 10,
                    width: 10,
                    
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.model.student} élèves',
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
              // Date and Time
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon10.svg',
                    height: 14,
                    width: 14,
                    
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 250,
                    child: Text(
                      '${widget.model.startDate} - ${widget.model.endDate}',
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
              const SizedBox(height: 16),
              // Cancellation Reason Section
              const Text(
                'Motif(s) de l\'annulation',
                style: TextStyle(
                  color: Color(0xFF04132C),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.44,
                ),
              ),
              const SizedBox(height: 8),
              
                  Expanded(
                    
                    child: 
                    Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFFB4B8C0),
                    width: 1,
                  ),
                ),
                child: 
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Déclarer une raison";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    controller: _reasonController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(
                      color: Color(0xFFCDD0D5),
                      fontSize: 14,
                      letterSpacing: -0.15,
                      height: 1.3,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                       fontSize: 14 
                      )
                    ),
                  ),
                  ),
              ),
              const SizedBox(height: 16),
              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showAbsentDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 90, 46, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Confirmer mon absence',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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

  void _showAbsentDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return AbsentDialog(modal: widget.model, sessionid: widget.model.sessionid, reason: _reasonController.text,);
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
