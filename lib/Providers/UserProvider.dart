import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wajed_delivery/Models/Driver.dart';
import 'package:wajed_delivery/Models/Market.dart';
import 'package:wajed_delivery/Models/MarketDetail.dart';
import 'package:wajed_delivery/Models/Order.dart';
import 'package:wajed_delivery/Models/OrderDetails.dart';
import 'package:wajed_delivery/Models/User.dart';
import 'package:wajed_delivery/Models/UserNotification.dart';
import 'package:wajed_delivery/UI/navigationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wajed_delivery/helpers/loading.dart';
import 'package:wajed_delivery/shared_data.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  login({email, password, context, Function onFaild}) async {
    print(password);
    showMyCustomLoadingDialog(context);
    var jsoMap = Map();
    jsoMap['email'] = email;
    jsoMap['password'] = password;
    final url = "$baseUrl/user/login";
    final response = await http.post(Uri.parse(url), body: jsoMap);
    print(response.body);
    if (response.statusCode == 200) {
       checkAuthintication(response, context);
       getProfile(context: context);
    } else {
      print(response.body);
      // HelperFunctions.slt.notifyUser(context: context,color: Colors.red,message: response.body);
    }
    pop(context);
    notifyListeners();
  }
  register({
    Map<String, String> jsoMap,
    context,
  }) async {
    showMyCustomLoadingDialog(context);
    jsoMap['role'] = 'driver';
    jsoMap['image'] = '1.png';
    jsoMap['device_token'] = 'none';
    notifyListeners();
    final url = "$baseUrl/user/register";
    final response = await http.post(Uri.parse(url), body: jsoMap);
    print(response.body);
    if (response.statusCode == 200) {
      checkAuthintication(response, context);
      getProfile(context: context);

    } else {
      print(response.body);
      // HelperFunctions.slt.notifyUser(context: context,color: Colors.red,message: response.body);
    }
    
    pop(context);
    notifyListeners();
  }
  List<Store> nearbyMarkets = [];
  getNearbyStors({lat, lng, context}) async {
    loading =true;
    final url = "$baseUrl/driver/nearby-markets";
    final response = await http.post(Uri.parse(url),
        body: {"lat": lat.toString(), "lng": lng.toString()});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data.forEach((element) {
        Store market = Store.fromJson(element['market']);
        market.distance = element['dist'].toDouble();
        nearbyMarkets.add(market);
      });
    } else {}
    loading =false;
    notifyListeners();
  }
  List<Store> searchMarkets = [];
  searchMarket({text, context}) async {
    searchMarkets = [];
    final url = "$baseUrl/driver/search-markets";
    final body = {
      "lat": locationData.latitude.toString(),
      "lng": locationData.longitude.toString(),
      "searchText":text
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
        data.forEach((element) {
        Store market = Store.fromJson(element['market']);
        market.distance = element['dist'];
        searchMarkets.add(market);
      });
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  MarketDetail marketDetail ;
  bool startLoading = true;
  getMarketDetail({marketId, context}) async {
    startLoading = true;
    final url = "$baseUrl/driver/get-market-detail";
    final body = {
      "lat": locationData.latitude.toString(),
      "lng": locationData.longitude.toString(),
      "marketId":marketId.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     marketDetail = MarketDetail.fromJson(data);
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }

  OrderDetail orderDetail;
  getOrderDetail({orderId, context}) async {
    startLoading = true;
    final url = "$baseUrl/driver/get-order-detail";
    print("hey ${orderId}");
    final body = {
      "id":orderId.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      orderDetail = OrderDetail.fromJson(data);
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }

 Driver driver ;
 bool profileLoad = true;
  getProfile({context}) async {
    startLoading=false;
    print("current : ${currentUser.id}");
    final url = "$baseUrl/driver/get-profile";
    final body = {
      "id":currentUser.id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      driver = Driver.fromJson(data);
      print("driver :" + driver.id.toString());

      print(response.body);
      updateLocation();
      UpdateDeviceToken();
    } else {
      print(response.body);
    }
    profileLoad = false;
    notifyListeners();
  }

  UpdateDeviceToken() async {
    await Firebase.initializeApp();
    String firetoken= await FirebaseMessaging().getToken();
    var jsoMap = Map();
    jsoMap['Token'] =firetoken;
    jsoMap['isDriver'] ="1";
    jsoMap['UserId'] = driver.id.toString();
    final url = "$baseUrl/user/update-deviceToken";
    final response = await http.post(Uri.parse(url), body: jsoMap);
    // print(firetoken);

    if (response.statusCode == 200) {
      print('yap  :  '+response.body);
    } else {
      print('yap  :  '+response.body);
    }
  }

  updateLocation() async {
    await getLocation();
    print("current : ${driver.id}");
    final url = "$baseUrl/driver/update-location";
    Map<String,dynamic> body = {
      "id":currentUser.id.toString(),
      "lat":locationData.latitude,
      "lng":locationData.longitude
    };
    final response = await http.post(Uri.parse(url), body: body);
    print(body);

    if (response.statusCode == 200) {
       print('good');
    } else {

      print('errrrrrrrrr');

    }
  }

  updatOrderStatus(status) async {
    final url = "$baseUrl/driver/update-order-status";
    final body = {
     "orderId":orderDetail.order.id.toString(),
     "driverId":driver.id.toString(),
      "status":status.toString()

    };
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body);
    if (response.statusCode == 200) {
      updateLocation();
      final data = jsonDecode(response.body);
      orderDetail.order = Order.fromJson(data);
      notifyListeners();
    }else{
    }
  }

  List<UserNotification> notifications = [] ;
  getNotifications({ context}) async {
    startLoading = true;
    notifications = [];
    final url = "$baseUrl/user/get-notifications";
    final body = {
      "id":currentUser.id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      data.forEach((element){
        notifications.add(UserNotification.fromJson(element));
      });
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }

  List<Order> currentOrders = [] ;
  getCurrentOrders({ context}) async {
    startLoading = true;
    currentOrders = [];
    final url = "$baseUrl/driver/get-orders";
    print("hey ${currentUser.id.toString()}");
    final body = {
      "id":currentUser.id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data.forEach((e){
        currentOrders.add(Order.fromJson(e));
      });
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }


  checkAuthintication(response, context) async {
    final data = jsonDecode(response.body);
    token = "Bearer " + data["token"];
    currentUser = UserModle.fromJson(data["customer"]);
    await saveToken();
    if (currentUser.role == "driver") {
      pushPage(context: context, page: NavigationPage());
    }
  }
}
