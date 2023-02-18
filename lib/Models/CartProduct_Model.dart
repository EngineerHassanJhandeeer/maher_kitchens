// class CartProductModel {
//   ////// Variablle
//   String? productId;
//   double? price;
//   double? singleItemPrice;
//   int? quantity;
//   String? pictureUrl;
//   String? productName;
//   double? subTotalPrice;
//   double? salesTax;
//   double? deliveryCharges;
//   double? totalPrice;
// ////// Consytructor
//   CartProductModel(
//       {this.productId,
//       this.price,
//       this.quantity,
//       this.pictureUrl,
//       this.productName,
//       this.subTotalPrice,
//       this.salesTax,
//       this.deliveryCharges,
//       this.totalPrice,
//       this.singleItemPrice});
//   /////////////////// Map Constructor
//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'price': price,
//       'quantity': quantity,
//       'pictureUrl': pictureUrl,
//       'productName': productName,
//       'subTotalPrice': subTotalPrice,
//       'salesTax': salesTax,
//       'deliveryCharges': deliveryCharges,
//       'totalPrice': totalPrice,
//       'singleItemPrice': singleItemPrice,
//     };
//   }

//   ////////////////FromMap Constuctor
//   CartProductModel.fromMap(Map<String, dynamic> map) {
//     productId = map['productId'];
//     price = map['price'];
//     quantity = map['quantity'];
//     pictureUrl = map['pictureUrl'];
//     productName = map['productName'];
//     subTotalPrice = map['subtotalPrice'];
//     salesTax = map['salesTax'];
//     deliveryCharges = map['deliveryCharges'];
//     totalPrice = map['totalPrice'];
//     singleItemPrice = map['singleItemPrice'];
//   }
//   static const String tableName = 'productTable';
//   static const String columnProductId = 'productId';
//   static const String columnPrice = 'price';
//   static const String columnQuantity = 'quantity';
//   static const String columnPictureUrl = 'pictureUrl';
//   static const String columnProductName = 'productName';
//   static const String columnSubTotalPrice = 'subTotalPrice';
//   static const String columnSalesTax = 'salesTax';
//   static const String columnDeliveryCharges = 'deliveryCharges';
//   static const String columnTotalPrice = 'totalPrice';
//   static const String columnSingleItemPrice = 'singleItemPrice';
//   static const String createTable =
//       'CREATE TABLE IF NOT EXISTS $tableName($columnProductId TEXT PRIMARY KEY , $columnPrice REAL,$columnSingleItemPrice REAL ,$columnQuantity INTEGER, $columnPictureUrl TEXT, $columnProductName TEXT, $columnSubTotalPrice REAL,$columnSalesTax REAL,$columnDeliveryCharges REAL,$columnTotalPrice REAL)';
//   static const String dropTable = 'DROP TABLE IF EXISTS $tableName';
// }

class CartProductModel {
  String? productId;
  double? price;
  double? singleItemPrice;
  int? quantity;
  String? pictureUrl;
  String? productName;
  double? subTotalPrice;
  double? salesTax;
  double? deliveryCharges;
  double? totalPrice;

  CartProductModel(
      {this.productId,
      this.price,
      this.quantity,
      this.pictureUrl,
      this.productName,
      this.subTotalPrice,
      this.salesTax,
      this.deliveryCharges,
      this.totalPrice,
      this.singleItemPrice});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'price': price,
      'quantity': quantity,
      'pictureUrl': pictureUrl,
      'productName': productName,
      'subTotalPrice': subTotalPrice,
      'salesTax': salesTax,
      'deliveryCharges': deliveryCharges,
      'totalPrice': totalPrice,
      'singleItemPrice': singleItemPrice,
    };
  }

  CartProductModel.fromMap(Map<String, dynamic> map) {
    productId = map['productId'];
    price = map['price'];
    quantity = map['quantity'];
    pictureUrl = map['pictureUrl'];
    productName = map['productName'];
    subTotalPrice = map['subtotalPrice'];
    salesTax = map['salesTax'];
    deliveryCharges = map['deliveryCharges'];
    totalPrice = map['totalPrice'];
    singleItemPrice = map['singleItemPrice'];
  }
  static const String tableName = 'productTable';
  static const String columnProductId = 'productId';
  static const String columnPrice = 'price';
  static const String columnQuantity = 'quantity';
  static const String columnPictureUrl = 'pictureUrl';
  static const String columnProductName = 'productName';
  static const String columnSubTotalPrice = 'subTotalPrice';
  static const String columnSalesTax = 'salesTax';
  static const String columnDeliveryCharges = 'deliveryCharges';
  static const String columnTotalPrice = 'totalPrice';
  static const String columnSingleItemPrice = 'singleItemPrice';
  static const String createTable =
      'CREATE TABLE IF NOT EXISTS $tableName($columnProductId TEXT PRIMARY KEY , $columnPrice REAL,$columnSingleItemPrice REAL ,$columnQuantity INTEGER, $columnPictureUrl TEXT, $columnProductName TEXT, $columnSubTotalPrice REAL,$columnSalesTax REAL,$columnDeliveryCharges REAL,$columnTotalPrice REAL)';
  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';
}
