import 'package:wajed_delivery/Models/Market.dart';
import 'package:wajed_delivery/Models/Order.dart';

class MarketDetail{
  Store market;
  double storeDistance;
  List<Order> orders=[];


  MarketDetail.fromJson(json){
    market = Store.fromJson(json['market']);
    storeDistance = json['distance'];
    json['orders'].forEach((element) {
     orders.add(Order.fromJson(element));
    });
  }
}