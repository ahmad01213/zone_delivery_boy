import 'dart:math';
import'dart:math' as Math;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:location/location.dart';
import 'package:wajed_delivery/Models/User.dart';
const firstColor = Colors.black;
const socondColor = Colors.blue;
const thirdColor = Colors.blue;
String firetoken;
String token;
final boxh15 = SizedBox(height: 15,);
final boxw15 = SizedBox(width: 15,);
pushPage({context,page }){
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page));
}
showSnackBar(message,context,{icon =Icons.check}) {
  Flushbar(
    message: message,
    icon: Icon(
      icon,
      size: 38.0,
      color: Colors.white,
    ),
    backgroundColor:firstColor.withOpacity(0.9),
    duration: Duration(seconds: 4),
    animationDuration: Duration(milliseconds: 300),
    leftBarIndicatorColor: Colors.white,
  )..show(context);
}
 titleText({title,color = firstColor,fSize = 15.0,isBold = false}){
    return Text(
      title,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: fSize,color: color,fontWeight: isBold?FontWeight.bold:FontWeight.normal),);
    }
subTitleText({title,color = Colors.black45,fSize = 12.0,isBold=false}){
  return Text(
    title,
    maxLines: 5,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: fSize,color: color,fontWeight: FontWeight.bold),);
}
LocationData locationData;

getLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
  print(locationData.latitude.toString()+" lat:");
}


pop(context) {
  Navigator.of(context).pop();
}

final testImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8YVFi6N1W6Sl7BSQJBK2Xs0S_4px-aDdqsw&usqp=CAU";

double twoDc(double val, int places) {
  double mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

final baseUrl = 'http://tall3ah.site/mobile';
final filesUrl = '';
final baseApiUrl = 'http://tall3ah.site/mobile';

getData(Map<String, dynamic> data) {
  return data['data'] ?? [];
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}


UserModle currentUser=UserModle();
saveToken(){
  final storage = new FlutterSecureStorage();
  storage.write(key: 'token', value: token);
  storage.write(key: 'name', value: currentUser.name);
  storage.write(key: 'email', value: currentUser.email);
  storage.write(key: 'id', value: currentUser.id.toString());
  storage.write(key: 'phone', value: currentUser.phone);
}


double getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
   try{
     var R = 6371; // Radius of the earth in km
     var dLat = deg2rad(lat2-lat1);  // deg2rad below
     var dLon = deg2rad(lon2-lon1);
     var a =
         Math.sin(dLat/2) * Math.sin(dLat/2) +
             Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
                 Math.sin(dLon/2) * Math.sin(dLon/2)
     ;
     var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
     var d = R * c; // Distance in km
     return d;
   }catch(e){
     return 0.0;
   }

}

double deg2rad(deg) {
  return deg * (Math.pi/180);
}