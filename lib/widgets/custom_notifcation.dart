import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/Models/notification_model.dart';
import 'package:olinom/screens/mission_notification.dart';
import 'package:olinom/services/noti_helper.dart';

class CustomNotification extends StatelessWidget {
  final NotificationModel model;

  const CustomNotification({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    NotiHelper notiHelper = NotiHelper.fromDescription(model.description!);
    return GestureDetector(
      child: Container(
      decoration: BoxDecoration(
        color: (model.isViewed) ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(204, 249, 250, 1),
        border: const Border(
          top: BorderSide(color: Color(0xFFE6E9F0), width: 1),
          bottom: BorderSide(color: Color(0xFFE6E9F0), width: 1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              'assets/icons/icon15.svg',
              height: 14,
              width: 14,
            ),
          ),
          
          const SizedBox(width: 18),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  '${model.subject}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(0, 91, 254, 1),
                    letterSpacing: -0.24,
                    height: 0.875,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Content
                Text(
                  '${notiHelper.body}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(79, 90, 107, 1),
                    letterSpacing: -0.03,
                    height: 1.21,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
      onDoubleTap: () {
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MissionNotification(
                    model: int.tryParse(notiHelper.missionId)!)));*/
      },
    );
  }

  Widget iconsSwitch(String widgetType) {
    switch (widgetType) {
      case "mission":
        return SvgPicture.asset('assets/icons/home.svg');
      case "session":
        return SvgPicture.asset('assets/icons/sessions.svg');
      default:
        return SvgPicture.asset('assets/icons/notification.svg');
    }
  }
}
