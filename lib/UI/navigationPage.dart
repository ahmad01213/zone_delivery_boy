import 'package:flutter/material.dart';
import 'package:wajed_delivery/UI/screens/account.dart';
import 'package:wajed_delivery/UI/screens/notifications.dart';
import 'package:wajed_delivery/UI/screens/orders.dart';
import 'package:wajed_delivery/UI/screens/stores.dart';
import 'package:wajed_delivery/UI/widgets/bottom_bar.dart';
import 'package:wajed_delivery/UI/widgets/settings.dart';

import '../shared_data.dart';
class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          children: pages,
          index: currentIndex,
        ),
      bottomNavigationBar: BottomNavBarView(changePage: changeScreen,)
    );
  }

 @override
  void initState() {

   super.initState();
  }

  List<Widget> pages = [
    Stores(),
    Orders(),
    NotificationPage(),
    Account()
  ];
  changeScreen({index}){
      setState(() {
        currentIndex = index;
      });
  }
}
