import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wajed_delivery/Models/OrderDetails.dart';
import 'package:http/http.dart' as http;
import '../shared_data.dart';

class OrderProvider extends ChangeNotifier{
 bool startLoading = true;

  OrderDetail orderDetail ;
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
}