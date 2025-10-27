import 'package:flutter/material.dart';
import 'package:olinom/services/local_storage.dart';
import 'package:olinom/screens/profile_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/screens/notification_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions; // Optional actions for the app bar
  final _apiConnection = ApiConnection();
  final bool hasUnreadNotifications;
  CustomAppBar({
    super.key,
    this.actions,
    this.hasUnreadNotifications = false,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard AppBar height

  Future<Map<String, String>> fetchUserData() async {
    await _apiConnection.userProfile();
    final _localStorage = LocalStorage();
    final results = await Future.wait([
      _localStorage.getJwtToken(),
      _localStorage.getFullname(),
      _localStorage.getPhoto(),
    ]);

    return {
      'token': results[0] ?? '',
      'fullname': results[1] ?? 'Guest',
      'photo': results[2] ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FutureBuilder<Map<String, String>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            final photo = snapshot.data?['photo'] ?? '';

            return Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE6E7EA),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: (photo.isNotEmpty)
                        ? Image.network(
                            photo,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('assets/images/profil-std.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            );
          },
        ),
        title: FutureBuilder<Map<String, String>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            final fullname = snapshot.data?['fullname'] ?? 'Loading...';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullname,
                  style: const TextStyle(
                    color: Color(0xFF04132C),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F7FF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Color(0xFF04132C), size: 22),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ),
                if (hasUnreadNotifications)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5A2E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
