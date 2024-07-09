// To parse this JSON data, do
//
//     final estoreProductCategoryModel = estoreProductCategoryModelFromJson(jsonString);

import 'dart:convert';

EstoreProductCategoryModel estoreProductCategoryModelFromJson(String str) =>
    EstoreProductCategoryModel.fromJson(json.decode(str));

class EstoreProductCategoryModel {
  bool? success;
  List<EstoreProductCategory>? categories;

  EstoreProductCategoryModel({
    this.success,
    this.categories,
  });

  factory EstoreProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      EstoreProductCategoryModel(
        success: json["success"],
        categories: List<EstoreProductCategory>.from(
            json["categories"].map((x) => EstoreProductCategory.fromJson(x))),
      );
}

class EstoreProductCategory {
  String? name;
  String? image;

  EstoreProductCategory({
    this.name,
    this.image,
  });

  factory EstoreProductCategory.fromJson(Map<String, dynamic> json) =>
      EstoreProductCategory(
        name: json["name"],
        image: json["image"],
      );
}
