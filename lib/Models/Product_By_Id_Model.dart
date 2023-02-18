class ProductByIdModel {
  int? productId;
  String? productName;
  double? salePrice;
  int? categoryId;
  String? imageFile;
  String? description;
  ProductByIdModel({
    this.productId,
    this.productName,
    this.salePrice,
    this.categoryId,
    this.imageFile,
    this.description,
  });

  ProductByIdModel.fromJson(dynamic json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    salePrice = json['SalePrice'];
    categoryId = json['CategoryId'];
    imageFile = json['ImageFile'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ProductId'] = productId;
    map['ProductName'] = productName;
    map['SalePrice'] = salePrice;
    map['CategoryId'] = categoryId;
    map['ImageFile'] = imageFile;
    map['Description'] = description;
    return map;
  }
}
