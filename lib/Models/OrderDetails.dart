import 'package:wajed_delivery/Models/Order.dart';
import 'package:wajed_delivery/Models/OrderFood.dart';


class OrderDetail{
  Order order;
  List<OrderFood> foods = [];
  OrderDetail.fromJson(json){
    order = Order.fromJson(json['order']);
    json['items'].forEach((e){
      foods.add(OrderFood.fromJson(e));
    });
  }
}