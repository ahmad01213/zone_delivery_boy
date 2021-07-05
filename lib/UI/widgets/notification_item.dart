import 'package:flutter/material.dart';
import 'package:wajed_delivery/Models/UserNotification.dart';
import 'package:wajed_delivery/shared_data.dart';
class NotificationItem extends StatelessWidget {
  UserNotification notification;
  NotificationItem(this.notification);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            filesUrl+notification.image,
            height: 70,
            width: 70,
            fit: BoxFit.fill,
          ),
        )
        ,boxw15,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(title: notification.body,color: Colors.black54),
            boxh15,
            subTitleText(title: notification.date,color: socondColor),
          ],
        )
      ],),
    );
  }
}
