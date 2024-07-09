// To parse this JSON data, do
//
//     final serchingModel = serchingModelFromJson(jsonString);

import 'dart:convert';

import 'estore_items_model.dart';

SerchingModel serchingModelFromJson(String str) =>
    SerchingModel.fromJson(json.decode(str));

class SerchingModel {
  bool? success;
  List<Products>? products;

  SerchingModel({
    this.success,
    this.products,
  });

  factory SerchingModel.fromJson(Map<String, dynamic> json) => SerchingModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<Products>.from(
                json["products"]!.map((x) => Products.fromJson(x))),
      );
}

class Products {
  Available? available;
  String? id;
  String? productName;
  String? description;
  String? brand;
  String? currency;
  String? appKey;
  List<dynamic>? tags;
  List<String>? images;
  List<dynamic>? reviews;
  List<Detail>? details;
  int? viewersCount;
  List<dynamic>? relatedProducts;
  String? variantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? category;

  Products({
    this.available,
    this.id,
    this.productName,
    this.description,
    this.brand,
    this.currency,
    this.appKey,
    this.tags,
    this.images,
    this.reviews,
    this.details,
    this.viewersCount,
    this.relatedProducts,
    this.variantId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.category,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        available: json["available"] == null
            ? null
            : Available.fromJson(json["available"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        brand: json["brand"],
        currency: json["currency"],
        appKey: json["appKey"],
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        viewersCount: json["viewersCount"],
        relatedProducts: json["relatedProducts"] == null
            ? []
            : List<dynamic>.from(json["relatedProducts"]!.map((x) => x)),
        variantId: json["variantId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        category: json["category"],
      );
}

class Available {
  bool? isAll;
  List<dynamic>? countries;

  Available({
    this.isAll,
    this.countries,
  });

  factory Available.fromJson(Map<String, dynamic> json) => Available(
        isAll: json["isAll"],
        countries: json["countries"] == null
            ? []
            : List<dynamic>.from(json["countries"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isAll": isAll,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x)),
      };
}
