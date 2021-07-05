import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/widgets/notification_item.dart';
import 'package:wajed_delivery/helpers/helpers.dart';

import '../../shared_data.dart';
class NotificationPage extends StatelessWidget {
  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      _userProvider.getNotifications(context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,

        title: titleText(fSize: 17.0,color: Colors.white,title: "التنبيهات"),
        centerTitle: true,
        backgroundColor: firstColor,
      ) ,
      body:_userProvider.startLoading?Center(
        child: SpinKitRing(
          size: 25,
          color: mainColor,
          lineWidth: 5,
          duration: Duration(milliseconds: 700),
        ),
      ): ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1),
          itemCount: _userProvider.notifications.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, i) {
            return NotificationItem(_userProvider.notifications[i]);
          }),
    );
  }
}
