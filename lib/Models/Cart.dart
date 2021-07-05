class Cart{
  int id;
  int user_id;
  int quantity;
  int food_id;
  int order_id;

  Cart.fromJson(json) {
    id = json["id"];
    user_id = json["user_id"];
    quantity = json["quantity"];
    food_id = json["food_id"];
    order_id = json["order_id"];
  }

}