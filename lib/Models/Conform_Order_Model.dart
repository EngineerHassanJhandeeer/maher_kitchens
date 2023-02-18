import 'dart:convert';

class ConfirmOrderModel {
  int? clientId;
  int? orderTotalAmount;
  int? orderAmount;
  int? taxAmount;
  String? orderDescription;
  String? deliveryAddress;
  String? deliveryPhoneNumber;
  int? taxPercentage;
  int? deliveryCharges;

  ConfirmOrderModel({
    this.clientId,
    this.orderTotalAmount,
    this.orderAmount,
    this.taxAmount,
    this.orderDescription,
    this.deliveryAddress,
    this.deliveryPhoneNumber,
    this.taxPercentage,
    this.deliveryCharges,
  });

  factory ConfirmOrderModel.fromJson(String str) =>
      ConfirmOrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConfirmOrderModel.fromMap(Map<String, dynamic> json) =>
      ConfirmOrderModel(
        clientId: json["ClientId"],
        orderTotalAmount: json["OrderTotalAmount"],
        orderAmount: json["OrderAmount"],
        taxAmount: json["TaxAmount"],
        orderDescription: json["OrderDescription"],
        deliveryAddress: json["DeliveryAddress"],
        deliveryPhoneNumber: json["DeliveryPhoneNumber"],
        taxPercentage: json["TaxPercentage"],
        deliveryCharges: json["DeliveryCharges"],
      );

  Map<String, dynamic> toMap() => {
        "ClientId": clientId,
        "OrderTotalAmount": orderTotalAmount,
        "OrderAmount": orderAmount,
        "TaxAmount": taxAmount,
        "OrderDescription": orderDescription,
        "DeliveryAddress": deliveryAddress,
        "DeliveryPhoneNumber": deliveryPhoneNumber,
        "TaxPercentage": taxPercentage,
        "DeliveryCharges": deliveryCharges,
      };
}
