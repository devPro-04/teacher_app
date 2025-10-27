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
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: FutureBuilder<Map<String, String>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          final photo = snapshot.data?['photo'] ?? '';

          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.0),
              child: GestureDetector(
                onTap: () {
                  // Handle tap
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: (photo.isNotEmpty)
                    ? Image.network(
                        photo,
                        fit: BoxFit.contain,
                      )
                    : const Image(
                        image: AssetImage('assets/images/profil-std.png')),
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
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.black, size: 24),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
            ),
            if (hasUnreadNotifications)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
