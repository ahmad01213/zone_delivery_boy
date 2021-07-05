import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/UI/screens/SignIn.dart';
import 'package:wajed_delivery/UI/screens/SplashScreen.dart';
import 'package:wajed_delivery/shared_data.dart';

import 'Providers/UserProvider.dart';
import 'UI/navigationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Future<void> initState()  {
    super.initState();

  }

  readFireToken() async {
    // firetoken = await _firebaseMessaging.getToken();
    // print('firetoken :  $firetoken');
  }





  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Wajed Delivery',
        debugShowCheckedModeBanner: false,

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        theme: ThemeData(
          primaryColor: firstColor,
          accentColor: socondColor,

          fontFamily: 'default',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:SplashScreen(),
      ),
    );
  }
}

