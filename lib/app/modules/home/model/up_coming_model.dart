// To parse this JSON data, do
//
//     final upcomingBookingModel = upcomingBookingModelFromJson(jsonString);

import 'dart:convert';

UpcomingBookingModel upcomingBookingModelFromJson(String str) =>
    UpcomingBookingModel.fromJson(json.decode(str));

String upcomingBookingModelToJson(UpcomingBookingModel data) =>
    json.encode(data.toJson());

class UpcomingBookingModel {
  String? message;
  List<BookingDetail>? bookingDetails;

  UpcomingBookingModel({
    this.message,
    this.bookingDetails,
  });

  factory UpcomingBookingModel.fromJson(Map<String, dynamic> json) =>
      UpcomingBookingModel(
        message: json["message"],
        bookingDetails: json["bookingDetails"] == null
            ? []
            : List<BookingDetail>.from(
                json["bookingDetails"]!.map((x) => BookingDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "bookingDetails": bookingDetails == null
            ? []
            : List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
      };
}

class BookingDetail {
  String? classId;
  Image? image;
  String? sloteId;
  String? bookingId;
  String? userId;
  DateTime? dateForSlot;
  bool? isAttended;
  AgeCategory? ageCategory;
  String? title;
  SlotTime? slotTime;

  BookingDetail({
    this.classId,
    this.image,
    this.sloteId,
    this.bookingId,
    this.userId,
    this.dateForSlot,
    this.isAttended,
    this.ageCategory,
    this.title,
    this.slotTime,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        classId: json["classId"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        sloteId: json["sloteId"],
        bookingId: json["bookingId"],
        userId: json["userId"],
        dateForSlot: json["dateForSlot"] == null
            ? null
            : DateTime.parse(json["dateForSlot"]),
        isAttended: json["isAttended"],
        ageCategory: json["ageCategory"] == null
            ? null
            : AgeCategory.fromJson(json["ageCategory"]),
        title: json["title"],
        slotTime: json["slotTime"] == null
            ? null
            : SlotTime.fromJson(json["slotTime"]),
      );

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "image": image?.toJson(),
        "sloteId": sloteId,
        "bookingId": bookingId,
        "userId": userId,
        "dateForSlot": dateForSlot?.toIso8601String(),
        "isAttended": isAttended,
        "ageCategory": ageCategory?.toJson(),
        "title": title,
        "slotTime": slotTime?.toJson(),
      };
}

class AgeCategory {
  int? fromAge;
  int? toAge;

  AgeCategory({
    this.fromAge,
    this.toAge,
  });

  factory AgeCategory.fromJson(Map<String, dynamic> json) => AgeCategory(
        fromAge: json["fromAge"],
        toAge: json["toAge"],
      );

  Map<String, dynamic> toJson() => {
        "fromAge": fromAge,
        "toAge": toAge,
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

class SlotTime {
  String? startTime;
  String? endTime;

  SlotTime({
    this.startTime,
    this.endTime,
  });

  factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}
