// import 'dart:convert';

// EStoreItemModel eStoreItemModelFromJson(String str) =>
//     EStoreItemModel.fromJson(json.decode(str));

// class EStoreItemModel {
//   bool? success;
//   String? message;
//   List<EStoreProduct>? products;

//   EStoreItemModel({
//     this.success,
//     this.message,
//     this.products,
//   });

//   factory EStoreItemModel.fromJson(Map<String, dynamic> json) =>
//       EStoreItemModel(
//         success: json["success"],
//         message: json["message"],
//         products: List<EStoreProduct>.from(
//             json["products"].map((x) => EStoreProduct.fromJson(x))),
//       );
// }

// class EStoreProduct {
//   // Available? available;
//   // Ratings? ratings;
//   // List<dynamic>? tags;
//   // List<dynamic>? reviews;
//   String? id;
//   // String? appKey;
//   String? brand;
//   // String? category;
//   List<Detail>? details;
//   List<dynamic>? images;
//   String? productName;
//   // String? variantName;
//   // int? viewersCount;
//   // List<RelatedProduct>? relatedProducts;
//   String? description;
//   bool? wishlist;
//   // int? cartCount;

//   EStoreProduct({
//     // this.available,
//     // this.ratings,
//     // this.tags,
//     // this.reviews,
//     this.id,
//     // this.appKey,
//     this.brand,
//     // this.category,
//     this.details,
//     this.images,
//     this.productName,
//     // this.variantName,
//     // this.viewersCount,
//     // this.relatedProducts,
//     this.description,
//     this.wishlist,
//     // this.cartCount,
//   });

//   factory EStoreProduct.fromJson(Map<String, dynamic> json) => EStoreProduct(
//         // available: Available.fromJson(json["available"]),
//         // ratings: Ratings.fromJson(json["ratings"]),
//         // tags: List<dynamic>.from(json["tags"].map((x) => x)),
//         // reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
//         id: json["_id"],
//         // appKey: json["appKey"],
//         brand: json["brand"],
//         // category: json["category"],
//         details: List<Detail>.from(json["details"].map((x) => x)),
//         images: List<String>.from(json["images"].map((x) => x)),
//         productName: json["productName"],
//         // variantName: json["variantName"],
//         // viewersCount: json["viewersCount"],
//         // relatedProducts: List<RelatedProduct>.from(
//         //     json["relatedProducts"].map((x) => RelatedProduct.fromJson(x))),
//         description: json["description"],
//         wishlist: json["wishlist"],
//         // cartCount: json["cartCount"],
//       );
// }

// class Available {
//   List<dynamic>? countries;
//   bool? isAll;

//   Available({
//     this.countries,
//     this.isAll,
//   });

//   factory Available.fromJson(Map<String, dynamic> json) => Available(
//         countries: List<dynamic>.from(json["countries"].map((x) => x)),
//         isAll: json["isAll"],
//       );
// }

// class Detail {
//   String? size;
// num? price;
// num? quantity;

//   Detail({
//     this.size,
//     this.price,
//     this.quantity,
//   });

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         size: json["size"],
//         price: json["price"],
//         quantity: json["quantity"],
//       );
// }

// class Ratings {
//   Ratings();

//   factory Ratings.fromJson(Map<String, dynamic> json) => Ratings();

//   Map<String, dynamic> toJson() => {};
// }

// class RelatedProduct {
//   Available? available;
//   List<dynamic>? tags;
//   List<dynamic>? reviews;
//   String? id;
//   String? appKey;
//   String? brand;
//   String? category;
//   List<Detail>? details;
//   List<String>? images;
//   String? productName;
//   String? variantName;
// num? viewersCount;
//   List<dynamic>? relatedProducts;
//   String? description;

//   RelatedProduct({
//     this.available,
//     this.tags,
//     this.reviews,
//     this.id,
//     this.appKey,
//     this.brand,
//     this.category,
//     this.details,
//     this.images,
//     this.productName,
//     this.variantName,
//     this.viewersCount,
//     this.relatedProducts,
//     this.description,
//   });

//   factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
//         available: Available.fromJson(json["available"]),
//         tags: List<dynamic>.from(json["tags"].map((x) => x)),
//         reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
//         id: json["_id"],
//         appKey: json["appKey"],
//         brand: json["brand"],
//         category: json["category"],
//         details:
//             List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
//         images: List<String>.from(json["images"].map((x) => x)),
//         productName: json["productName"],
//         variantName: json["variantName"],
//         viewersCount: json["viewersCount"],
//         relatedProducts:
//             List<String>.from(json["relatedProducts"].map((x) => [x])),
//         description: json["description"],
//       );
// }

// To parse this JSON data, do
//
//     final getEstoreOrderHistory = getEstoreOrderHistoryFromJson(jsonString);
// To parse this JSON data, do
//
//     final eStoreItemModel = eStoreItemModelFromJson(jsonString);

import 'dart:convert';

EStoreItemModel eStoreItemModelFromJson(String str) =>
    EStoreItemModel.fromJson(json.decode(str));

class EStoreItemModel {
  bool? success;
  String? message;
  List<EStoreProduct>? products;
  dynamic totalProducts;

  EStoreItemModel({
    this.success,
    this.message,
    this.products,
    this.totalProducts,
  });

  factory EStoreItemModel.fromJson(Map<String, dynamic> json) =>
      EStoreItemModel(
        success: json["success"],
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<EStoreProduct>.from(
                json["products"]!.map((x) => EStoreProduct.fromJson(x))),
        totalProducts: json["totalProducts"],
      );
}

class EStoreProduct {
  // Available? available;

  String? id;
  String? productName;
  String? description;
  String? brand;
  // String? currency;
  // String? appKey;
  // List<dynamic>? tags;
  List<String>? images;
  // List<dynamic>? reviews;
  dynamic viewersCount;
  // List<dynamic>? relatedProducts;
  List<Detail>? details;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // int? v;
  bool? wishlist;

  EStoreProduct({
    // this.available,
    this.id,
    this.productName,
    this.description,
    this.brand,
    // this.currency,
    // this.appKey,
    // this.tags,
    this.images,
    // this.reviews,
    this.viewersCount,
    // this.relatedProducts,
    this.details,
    // this.createdAt,
    // this.updatedAt,
    // this.v,
    this.wishlist,
  });

  factory EStoreProduct.fromJson(Map<String, dynamic> json) => EStoreProduct(
        // available: Available.fromJson(json["available"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        brand: json["brand"],
        // currency: json["currency"],
        // appKey: json["appKey"],
        // tags: List<dynamic>.from(json["tags"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
        // reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        viewersCount: json["viewersCount"],
        // relatedProducts:
        //     List<dynamic>.from(json["relatedProducts"].map((x) => x)),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
        wishlist: json["wishlist"],
      );
}

// class Available {
//   bool? isAll;
//   List<dynamic>? countries;

//   Available({
//     this.isAll,
//     this.countries,
//   });

//   factory Available.fromJson(Map<String, dynamic> json) => Available(
//         isAll: json["isAll"],
//         countries: List<dynamic>.from(json["countries"].map((x) => x)),
//       );
// }

class Detail {
  dynamic size;
  dynamic quantity;
  dynamic price;

  Detail({
    this.size,
    this.quantity,
    this.price,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        size: json["size"],
        quantity: json["quantity"],
        price: json["price"],
      );
}
