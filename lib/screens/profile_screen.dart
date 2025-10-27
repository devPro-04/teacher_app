import 'package:flutter/material.dart';
import 'package:olinom/screens/splash_screen.dart';
import 'package:olinom/widgets/main_button.dart';
import 'package:olinom/services/local_storage.dart';

class ProfileScreen extends StatelessWidget {
  final localStorage = LocalStorage();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/556669/pexels-photo-556669.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                    radius: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Hello!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MainButton(
                    buttonText: "log out",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Return the AlertDialog
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content:
                                const Text('Are you sure you want to Log out?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async {
                                  await localStorage.deleteJwtToken();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
