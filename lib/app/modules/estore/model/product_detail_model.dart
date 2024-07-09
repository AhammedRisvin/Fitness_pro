import 'dart:convert';

EstoreProductDetailModel estoreProductDetailModelFromJson(String str) =>
    EstoreProductDetailModel.fromJson(json.decode(str));

class EstoreProductDetailModel {
  bool? success;
  String? message;
  EStoreProductDetail? product;

  EstoreProductDetailModel({
    this.success,
    this.message,
    this.product,
  });

  factory EstoreProductDetailModel.fromJson(Map<String, dynamic> json) =>
      EstoreProductDetailModel(
        success: json["success"],
        message: json["message"],
        product: EStoreProductDetail.fromJson(json["product"]),
      );
}

class EStoreProductDetail {
  // Available? available;
  // Ratings? ratings;
  // List<dynamic>? tags;
  // List<dynamic>? reviews;
  String? id;
  // String? appKey;
  String? brand;
  String? category;
  List<Detail>? details;
  List<String>? images;
  String? productName;
  // String? variantName;
  // int? viewersCount;
  List<RelatedProduct>? relatedProducts;
  String? description;
  bool? wishlist;
  dynamic cartCount;

  EStoreProductDetail({
    // this.available,
    // this.ratings,
    // this.tags,
    // this.reviews,
    this.id,
    // this.appKey,
    this.brand,
    this.category,
    this.details,
    this.images,
    this.productName,
    // this.variantName,
    // this.viewersCount,
    this.relatedProducts,
    this.description,
    this.wishlist,
    this.cartCount,
  });

  factory EStoreProductDetail.fromJson(Map<String, dynamic> json) =>
      EStoreProductDetail(
        // available: Available.fromJson(json["available"]),
        // ratings: Ratings.fromJson(json["ratings"]),
        // tags: List<dynamic>.from(json["tags"].map((x) => x)),
        // reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        id: json["_id"],
        // appKey: json["appKey"],
        brand: json["brand"],
        category: json["category"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        productName: json["productName"],
        // variantName: json["variantName"],
        // viewersCount: json["viewersCount"],
        relatedProducts: List<RelatedProduct>.from(
            json["relatedProducts"].map((x) => RelatedProduct.fromJson(x))),
        description: json["description"],
        wishlist: json["wishlist"],
        cartCount: json["cartCount"],
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

class Ratings {
  Ratings();

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings();

  Map<String, dynamic> toJson() => {};
}

class RelatedProduct {
  // Available? available;
  // List<dynamic>? tags;
  // List<dynamic>? reviews;
  String? id;
  // String? appKey;
  String? brand;
  String? category;
  List<Detail>? details;
  List<String>? images;
  String? productName;
  // String? variantName;
  // int? viewersCount;
  // List<dynamic>? relatedProducts;
  String? description;

  RelatedProduct({
    // this.available,
    // this.tags,
    // this.reviews,
    this.id,
    // this.appKey,
    this.brand,
    this.category,
    this.details,
    this.images,
    this.productName,
    // this.variantName,
    // this.viewersCount,
    // this.relatedProducts,
    this.description,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
        // available: Available.fromJson(json["available"]),
        // tags: List<dynamic>.from(json["tags"].map((x) => x)),
        // reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        id: json["_id"] ?? '',
        // appKey: json["appKey"] ?? '',
        brand: json["brand"] ?? '',
        category: json["category"] ?? '',
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
        productName: json["productName"] ?? '',
        // variantName: json["variantName"] ?? '',
        // viewersCount: json["viewersCount"],
        // relatedProducts:
        //     List<String>.from(json["relatedProducts"].map((x) => [x])),
        description: json["description"] ?? '',
      );
}
