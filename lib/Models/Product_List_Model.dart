// class ProductListModel {
//   int? productId;
//   String? productName;
//   int? salePrice;
//   int? categoryId;
//   String? imageFile;
//   String? description;

//   ProductListModel(
//       {this.productId,
//       this.productName,
//       this.salePrice,
//       this.categoryId,
//       this.imageFile,
//       this.description});

//   ProductListModel.fromJson(Map<String, dynamic> json) {
//     productId = json['ProductId'];
//     productName = json['ProductName'];
//     salePrice = json['SalePrice'];
//     categoryId = json['CategoryId'];
//     imageFile = json['ImageFile'];
//     description = json['Description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ProductId'] = this.productId;
//     data['ProductName'] = this.productName;
//     data['SalePrice'] = this.salePrice;
//     data['CategoryId'] = this.categoryId;
//     data['ImageFile'] = this.imageFile;
//     data['Description'] = this.description;
//     return data;
//   }
// }

// import 'dart:convert';

// ProductListModel productListModelFromJson(String str) =>
//     ProductListModel.fromJson(json.decode(str));

// String productListModelToJson(ProductListModel data) =>
//     json.encode(data.toJson());

// class ProductListModel {
//   ProductListModel({
//     this.categoryId,
//     this.categoryTitle,
//     this.imageFile,
//   });

//   int? categoryId;
//   String? categoryTitle;
//   String? imageFile;

//   factory ProductListModel.fromJson(Map<String, dynamic> json) =>
//       ProductListModel(
//         categoryId: json["CategoryId"],
//         categoryTitle: json["CategoryTitle"],
//         imageFile: json["ImageFile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "CategoryId": categoryId,
//         "CategoryTitle": categoryTitle,
//         "ImageFile": imageFile,
//       };
// }
import 'dart:convert';

class ProductListModel {
  int? categoryId;
  String? categoryTitle;
  String? imageFile;

  ProductListModel({
    this.categoryId,
    this.categoryTitle,
    this.imageFile,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        categoryId: json["CategoryId"],
        categoryTitle: json["CategoryTitle"],
        imageFile: json["ImageFile"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "CategoryTitle": categoryTitle,
        "ImageFile": imageFile,
      };
}
