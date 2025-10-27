import 'package:flutter/material.dart';
import 'package:olinom/Models/notification_model.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/widgets/custom_notifcation.dart';
// import 'package:olinom/widgets/appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final apiConnection = ApiConnection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width < 500
          ? MediaQuery.of(context).size.height * 0.78
          : MediaQuery.of(context).size.height * 0.64,
      child: FutureBuilder<List<NotificationModel>>(
        future: apiConnection.getNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF005BFE)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final notification = snapshot.data ?? [];
            // Build your ListView or other widgets to display the notification data
            return notification.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'No notification available',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: notification.length,
                    itemBuilder: (context, index) {
                      final mission = notification[index];
                      return CustomNotification(model: mission);
                    },
                  );
          }
        },
      ),
    );
  }
}
