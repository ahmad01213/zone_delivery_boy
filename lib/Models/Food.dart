
import 'package:wajed_delivery/Models/Option.dart';
import 'package:wajed_delivery/Models/OptionGroup.dart';

class Food{

  int id;
  String name;
  String image;
  String desc;
  int price;
  int category_id;
  int market_id;
  List<Option> options;
  List<OptionGroup> optionGroups;

  Food.fromJson(json) {
    id = json["id"];
    name = json["name"];
    desc = json["desc"];
    price = json["price"];
    image = json["image"];
    category_id = json["category_id"];
    market_id = json["market_id"];
  }


}