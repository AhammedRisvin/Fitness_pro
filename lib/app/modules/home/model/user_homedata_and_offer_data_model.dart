class UserHomeDataAndOfferDataModel {
  String? message;
  UserData? userData;
  int? classLeft;
  List<CarouselData>? carouselDatas;

  UserHomeDataAndOfferDataModel({
    this.message,
    this.userData,
    this.classLeft,
    this.carouselDatas,
  });

  factory UserHomeDataAndOfferDataModel.fromJson(Map<String, dynamic> json) =>
      UserHomeDataAndOfferDataModel(
        message: json["message"],
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
        classLeft: json["classLeft"],
        carouselDatas: json["carouselDatas"] == null
            ? []
            : List<CarouselData>.from(
                json["carouselDatas"]!.map((x) => CarouselData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "userData": userData?.toJson(),
        "classLeft": classLeft,
        "carouselDatas": carouselDatas == null
            ? []
            : List<dynamic>.from(carouselDatas!.map((x) => x.toJson())),
      };
}

class CarouselData {
  CarouselImage? carouselImage;
  String? id;
  String? offer;
  int? v;

  CarouselData({
    this.carouselImage,
    this.id,
    this.offer,
    this.v,
  });

  factory CarouselData.fromJson(Map<String, dynamic> json) => CarouselData(
        carouselImage: json["carouselImage"] == null
            ? null
            : CarouselImage.fromJson(json["carouselImage"]),
        id: json["_id"],
        offer: json["offer"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "carouselImage": carouselImage?.toJson(),
        "_id": id,
        "offer": offer,
        "__v": v,
      };
}

class CarouselImage {
  String? url;

  CarouselImage({
    this.url,
  });

  factory CarouselImage.fromJson(Map<String, dynamic> json) => CarouselImage(
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
      };
}

class UserData {
  Image? image;
  String? id;
  String? name;
  DateTime? planExpiringDate;
  int? totalClasses;
  int? bookedClasses;

  UserData({
    this.image,
    this.id,
    this.name,
    this.planExpiringDate,
    this.totalClasses,
    this.bookedClasses,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        id: json["_id"],
        name: json["name"],
        planExpiringDate: json["planExpiringDate"] == null
            ? null
            : DateTime.parse(json["planExpiringDate"]),
        totalClasses: json["totalClasses"],
        bookedClasses: json["bookedClasses"],
      );

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "_id": id,
        "name": name,
        "planExpiringDate": planExpiringDate,
        "totalClasses": totalClasses,
        "bookedClasses": bookedClasses,
      };
}

class Image {
  String? url;

  Image({
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
      };
}
