import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wajed_delivery/UI/navigationPage.dart';
import 'package:wajed_delivery/UI/screens/login_register.dart';
import 'package:wajed_delivery/models/user.dart';
import '../../shared_data.dart';
class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // readToken(context);
    return Scaffold();
  }
  // readToken(context) async {
  //   final storage = new FlutterSecureStorage();
  //   token = await storage.read(key: "token");
  //   String name = await storage.read(key: "name");
  //   String phone = await storage.read(key: "phone");
  //   String email = await storage.read(key: "email");
  //   user = User(name: name,phone: phone,email:email );
  //   if(token!=null){
  //     navigateTo(context: context,page: NavigationPage());
  //   }else{
  //     navigateTo(context: context,page: Login());
  //   }
  }

