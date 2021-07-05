class Store{
  int id;
  String title;
  int user_id;
  int balance;
  String image;
  int field_id;
  double lat;
  double lng;
  String status;
  String summary;
  int rate;
  double distance;
  double ds;
  int order_count;
  int picks;

  Store.fromJson(json) {
    id = json["id"];
    user_id = json["user_id"];
    title = json["title"];
    balance = json["balance"];
    image = json["image"];
    field_id = json["field_id"];
    lat = json["lat"].toDouble();
    lng = json["lng"].toDouble();
    status = json["status"];
    summary = json["summary"];
    rate = json["rate"];
    order_count = json["order_count"];
    picks = json["picks"];
  }

}