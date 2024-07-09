import 'estore_items_model.dart';

class GetEstoreOrderHistory {
  String? message;
  List<OrderElement>? orders;

  GetEstoreOrderHistory({
    this.message,
    this.orders,
  });

  factory GetEstoreOrderHistory.fromJson(Map<String, dynamic> json) =>
      GetEstoreOrderHistory(
        message: json["message"],
        orders: json["orders"] == null
            ? []
            : List<OrderElement>.from(
                json["orders"]!.map((x) => OrderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class OrderElement {
  OrderOrder? order;
  String? id;

  OrderElement({
    this.order,
    this.id,
  });

  factory OrderElement.fromJson(Map<String, dynamic> json) => OrderElement(
        order:
            json["order"] == null ? null : OrderOrder.fromJson(json["order"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "_id": id,
      };
}

class OrderOrder {
  String? id;
  List<ItemElement>? items;
  String? status;
  String? paymentMethod;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OrderOrder({
    this.id,
    this.items,
    this.status,
    this.paymentMethod,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OrderOrder.fromJson(Map<String, dynamic> json) => OrderOrder(
        id: json["_id"],
        items: json["items"] == null
            ? []
            : List<ItemElement>.from(
                json["items"]!.map((x) => ItemElement.fromJson(x))),
        status: json["status"],
        paymentMethod: json["paymentMethod"],
        amount: json["amount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "status": status,
        "paymentMethod": paymentMethod,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class ItemElement {
  ItemItem? item;
  int? quantity;
  String? size;
  int? price;
  String? id;

  ItemElement({
    this.item,
    this.quantity,
    this.size,
    this.price,
    this.id,
  });

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        item: json["item"] == null ? null : ItemItem.fromJson(json["item"]),
        quantity: json["quantity"],
        size: json["size"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "size": size,
        "price": price,
        "_id": id,
      };
}

class ItemItem {
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
  List<String>? relatedProducts;
  String? variantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? category;

  ItemItem({
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

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
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
            : List<String>.from(json["relatedProducts"]!.map((x) => x)),
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
