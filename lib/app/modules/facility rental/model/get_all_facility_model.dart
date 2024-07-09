class GetAllFacilityModel {
  String? message;
  List<SloteData>? sloteDatas;

  GetAllFacilityModel({
    this.message,
    this.sloteDatas,
  });

  factory GetAllFacilityModel.fromJson(Map<String, dynamic> json) =>
      GetAllFacilityModel(
        message: json["message"],
        sloteDatas: json["sloteDatas"] == null
            ? []
            : List<SloteData>.from(
                json["sloteDatas"]!.map((x) => SloteData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sloteDatas": sloteDatas == null
            ? []
            : List<dynamic>.from(sloteDatas!.map((x) => x.toJson())),
      };
}

class SloteData {
  Image? image;
  String? id;
  Branch? branch;
  String? name;
  String? about;
  String? address;
  bool? isDeleted;
  List<Slote>? slotes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SloteData({
    this.image,
    this.id,
    this.branch,
    this.name,
    this.about,
    this.address,
    this.isDeleted,
    this.slotes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SloteData.fromJson(Map<String, dynamic> json) => SloteData(
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        id: json["_id"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        name: json["name"],
        about: json["about"],
        address: json["address"],
        isDeleted: json["isDeleted"],
        slotes: json["slotes"] == null
            ? []
            : List<Slote>.from(json["slotes"]!.map((x) => Slote.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "_id": id,
        "branch": branch?.toJson(),
        "name": name,
        "about": about,
        "address": address,
        "isDeleted": isDeleted,
        "slotes": slotes == null
            ? []
            : List<dynamic>.from(slotes!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Branch {
  Address? address;
  String? id;
  String? branchName;
  int? v;
  bool? isDelete;

  Branch({
    this.address,
    this.id,
    this.branchName,
    this.v,
    this.isDelete,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        address:
            json["Address"] == null ? null : Address.fromJson(json["Address"]),
        id: json["_id"],
        branchName: json["branchName"],
        v: json["__v"],
        isDelete: json["isDelete"],
      );

  Map<String, dynamic> toJson() => {
        "Address": address?.toJson(),
        "_id": id,
        "branchName": branchName,
        "__v": v,
        "isDelete": isDelete,
      };
}

class Address {
  String? city;
  String? country;
  String? zipCode;

  Address({
    this.city,
    this.country,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        zipCode: json["zipCode"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "zipCode": zipCode,
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

class Slote {
  Time? time;
  Date? date;
  Fees? fees;
  bool? allDates;
  String? id;
  List<BookedUsersDetail>? bookedUsersDetails;
  List<DateTime>? isBooked;

  Slote({
    this.time,
    this.date,
    this.fees,
    this.allDates,
    this.id,
    this.bookedUsersDetails,
    this.isBooked,
  });

  factory Slote.fromJson(Map<String, dynamic> json) => Slote(
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        fees: json["fees"] == null ? null : Fees.fromJson(json["fees"]),
        allDates: json["allDates"],
        id: json["_id"],
        bookedUsersDetails: json["bookedUsersDetails"] == null
            ? []
            : List<BookedUsersDetail>.from(json["bookedUsersDetails"]!
                .map((x) => BookedUsersDetail.fromJson(x))),
        isBooked: json["isBooked"] == null
            ? []
            : List<DateTime>.from(
                json["isBooked"]!.map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "date": date?.toJson(),
        "fees": fees?.toJson(),
        "allDates": allDates,
        "_id": id,
        "bookedUsersDetails": bookedUsersDetails == null
            ? []
            : List<dynamic>.from(bookedUsersDetails!.map((x) => x.toJson())),
        "isBooked": isBooked == null
            ? []
            : List<dynamic>.from(isBooked!.map((x) => x.toIso8601String())),
      };
}

class BookedUsersDetail {
  String? userId;
  String? bookingStatus;
  DateTime? dateForSlot;
  String? id;

  BookedUsersDetail({
    this.userId,
    this.bookingStatus,
    this.dateForSlot,
    this.id,
  });

  factory BookedUsersDetail.fromJson(Map<String, dynamic> json) =>
      BookedUsersDetail(
        userId: json["userId"],
        bookingStatus: json["bookingStatus"],
        dateForSlot: json["dateForSlot"] == null
            ? null
            : DateTime.parse(json["dateForSlot"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "bookingStatus": bookingStatus,
        "dateForSlot": dateForSlot?.toIso8601String(),
        "_id": id,
      };
}

class Date {
  DateTime? startDate;
  DateTime? endDate;

  Date({
    this.startDate,
    this.endDate,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}

class Fees {
  int? amount;
  String? currency;

  Fees({
    this.amount,
    this.currency,
  });

  factory Fees.fromJson(Map<String, dynamic> json) => Fees(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}

class Time {
  String? startTime;
  String? endTime;

  Time({
    this.startTime,
    this.endTime,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}
