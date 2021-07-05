class Driver{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String role;
  int rate;
  int userId;
  int reviews;
  int orderCount;
  int balance;
  String status;
  String address;
  double lat;
  double lng;
  String deviceToken;

  Driver.fromJson(json) {
    id = json['id'];
    reviews = json['reviews'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    role = json['role'];
    rate = json['rate'];
    userId = json['user_id'];
    orderCount = json['order_count'];
    balance = json['balance'];
    status = json['status'];
    address = json['address'];
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    deviceToken = json['device_token'];
  }
}