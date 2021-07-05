class UserModle{
  int id;
  String name;
  String email;

  UserModle( );

  String phone;
  String image;
  String role;
  UserModle.fromJson(json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    role = json["role"];
  }
}