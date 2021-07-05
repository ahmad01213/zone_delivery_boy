import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wajed_delivery/Models/User.dart';
import 'package:wajed_delivery/shared_data.dart';
//
// pushPage({context, page}) {
//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
// }

var scaffoldKey = GlobalKey<ScaffoldState>();

showMessage(message){
  scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(message)));

}
// User user = User();
final count =
ValueNotifier<int>(0);
String isFirstLaunch;

saveToken() {
  final storage = new FlutterSecureStorage();
  storage.write(key: 'token', value: token);
  storage.write(key: 'id', value: currentUser.id.toString());
}

saveValue(key, value) {
  final storage = new FlutterSecureStorage();
  storage.write(key: key, value: value);
}

isRegistered() {
  return token != null;
}

signOut({ctx, page}) async {
  final storage = new FlutterSecureStorage();
  token = null;
  await storage.delete(key: "token");
  await storage.delete(key: "id");
  currentUser=UserModle();
  replacePage(context: ctx, page: page);
}

isFirst() {
  return isFirstLaunch == null;
}

readToken() async {
  final storage = new FlutterSecureStorage();
  token = await storage.read(key: "token");
  final id = await storage.read(key: "id");
  print("storage :" +id.toString());
  if(id!=null) currentUser.id = int.parse(id) ;
}

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}


final defaultShadow = BoxShadow(
  color: Colors.black.withOpacity(0.1),
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(0, 1), // changes position of shadow
);



// final baseUrl = "http://tall3ah.site/mobile";
// final filesUrl = "http://tall3ah.site/uploads/";
// final baseDashboardUrl = "http://tall3ah.site";


String userRole = 'user';
double screenWidth;
double screenHight;

bool isTablet() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide > 600;
}


const mainColor =Colors.black;
const secondColor = Color(0xFFFCDA00);
const textColor = Color(0xFF343A40);
Color greyColor = Colors.grey.withOpacity(0.1);




List<String> imgs = [
  "4.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
];

