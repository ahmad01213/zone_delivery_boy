
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/screens/SignIn.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import '../../shared_data.dart';
import '../navigationPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  UserProvider _userProvider;
  initData(context) async {

    // signOut(ctx: context,page: SignInScreen());
    if(_userProvider==null){
      _userProvider=Provider.of(context);
     await readToken();
     await getLocation();
     if(token!=null){
       await _userProvider.getProfile(context: context);
       replacePage(context: context,page: NavigationPage());

     }else{
       replacePage(context: context,page: SignInScreen());

     }
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/img/logo.png',height: 150,width: 150,))),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }
}
