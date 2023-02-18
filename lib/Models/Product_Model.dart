class ProductModel {
  int? productId;
  String? productName;
  double? salePrice;
  int? catagoryId;
  String? image;
  String? description;

  ProductModel(
      {required this.productId,
      required this.productName,
      required this.salePrice,
      required this.catagoryId,
      required this.description,
      required this.image});

  ProductModel.fromJson(Map<String, dynamic> map) {
    productId = map['ProductId'];
    productName = map['ProductName'];
    salePrice = map['SalePrice'];
    catagoryId = map['CategoryId'];
    image = map['ImageFile'];
    description = map['Description'];
  }
}
