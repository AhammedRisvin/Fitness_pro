// To parse this JSON data, do
//
//     final estoreProductWishListModel = estoreProductWishListModelFromJson(jsonString);

import 'dart:convert';

EstoreProductWishListModel estoreProductWishListModelFromJson(String str) =>
    EstoreProductWishListModel.fromJson(json.decode(str));

class EstoreProductWishListModel {
  bool? success;
  String? message;
  List<EstoreWishlist>? wishlists;

  EstoreProductWishListModel({
    this.success,
    this.message,
    this.wishlists,
  });

  factory EstoreProductWishListModel.fromJson(Map<String, dynamic> json) =>
      EstoreProductWishListModel(
        success: json["success"],
        message: json["message"],
        wishlists: List<EstoreWishlist>.from(
            json["wishlists"].map((x) => EstoreWishlist.fromJson(x))),
      );
}

class EstoreWishlist {
  Product? product;

  EstoreWishlist({
    this.product,
  });

  factory EstoreWishlist.fromJson(Map<String, dynamic> json) => EstoreWishlist(
        product: Product.fromJson(json["product"]),
      );
}

class Product {
  Available? available;
  List<dynamic>? tags;
  List<dynamic>? reviews;
  String? id;
  String? appKey;
  String? brand;
  String? category;
  List<Detail>? details;
  List<String>? images;
  String? productName;
  String? variantName;
  int? viewersCount;
  List<String>? relatedProducts;
  String? description;
  DateTime? updatedAt;

  Product({
    this.available,
    this.tags,
    this.reviews,
    this.id,
    this.appKey,
    this.brand,
    this.category,
    this.details,
    this.images,
    this.productName,
    this.variantName,
    this.viewersCount,
    this.relatedProducts,
    this.description,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: Available.fromJson(json["available"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        id: json["_id"],
        appKey: json["appKey"],
        brand: json["brand"],
        category: json["category"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        productName: json["productName"],
        variantName: json["variantName"],
        viewersCount: json["viewersCount"],
        relatedProducts:
            List<String>.from(json["relatedProducts"].map((x) => x)),
        description: json["description"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class Available {
  List<dynamic>? countries;
  bool? isAll;

  Available({
    this.countries,
    this.isAll,
  });

  factory Available.fromJson(Map<String, dynamic> json) => Available(
        countries: List<dynamic>.from(json["countries"].map((x) => x)),
        isAll: json["isAll"],
      );
}

class Detail {
  String? size;
  dynamic price;
  dynamic quantity;

  Detail({
    this.size,
    this.price,
    this.quantity,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        size: json["size"],
        price: json["price"],
        quantity: json["quantity"],
      );
}
