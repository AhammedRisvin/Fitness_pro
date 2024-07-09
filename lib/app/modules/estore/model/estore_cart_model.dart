// To parse this JSON data, do
//
//     final eStoreCartModel = eStoreCartModelFromJson(jsonString);

import 'dart:convert';

import 'estore_items_model.dart';

EStoreCartModel eStoreCartModelFromJson(String str) =>
    EStoreCartModel.fromJson(json.decode(str));

class EStoreCartModel {
  bool? success;
  String? message;
  List<EStoreCart>? carts;

  EStoreCartModel({
    this.success,
    this.message,
    this.carts,
  });

  factory EStoreCartModel.fromJson(Map<String, dynamic> json) =>
      EStoreCartModel(
        success: json["success"],
        message: json["message"],
        carts: List<EStoreCart>.from(
            json["carts"].map((x) => EStoreCart.fromJson(x))),
      );
}

class EStoreCart {
  Product? product;
  int? count;
  String? size;
  String? id;
  EStoreCart({
    this.product,
    this.count,
    this.id,
    this.size,
  });

  factory EStoreCart.fromJson(Map<String, dynamic> json) => EStoreCart(
        product: Product.fromJson(json["product"]),
        count: json["count"],
        size: json["size"] ?? '',
        id: json["_id"],
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
  int? prize;

  Product(
      {this.available,
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
      this.prize});

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
