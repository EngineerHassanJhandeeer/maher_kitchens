import 'dart:convert';

class ProceedToCheckOutModel {
  int? orderId;
  int? productId;
  int? quantity;
  int? price;

  ProceedToCheckOutModel({
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
  });

  factory ProceedToCheckOutModel.fromJson(String str) =>
      ProceedToCheckOutModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProceedToCheckOutModel.fromMap(Map<String, dynamic> json) =>
      ProceedToCheckOutModel(
          orderId: json["OrderId"],
          productId: json["ProductId"],
          quantity: json["Quantity"],
          price: json["Price"]);

  Map<String, dynamic> toMap() => {
        "OrderId": orderId,
        "ProductId": productId,
        "Quantity": quantity,
        "Price": price
      };
}
