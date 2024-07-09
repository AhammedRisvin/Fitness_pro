// To parse this JSON data, do
//
//     final completedBookingModel = completedBookingModelFromJson(jsonString);

import 'dart:convert';

CompletedBookingModel completedBookingModelFromJson(String str) =>
    CompletedBookingModel.fromJson(json.decode(str));

String completedBookingModelToJson(CompletedBookingModel data) =>
    json.encode(data.toJson());

class CompletedBookingModel {
  String? message;
  List<BookingDetails>? bookingDetails;

  CompletedBookingModel({
    this.message,
    this.bookingDetails,
  });

  factory CompletedBookingModel.fromJson(Map<String, dynamic> json) =>
      CompletedBookingModel(
        message: json["message"],
        bookingDetails: json["bookingDetails"] == null
            ? []
            : List<BookingDetails>.from(
                json["bookingDetails"]!.map((x) => BookingDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "bookingDetails": bookingDetails == null
            ? []
            : List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
      };
}

class BookingDetails {
  String? userId;
  DateTime? dateForSlot;
  bool? isAttended;
  AgeCategory? ageCategory;
  String? title;
  SlotTime? slotTime;
  Image? image;

  BookingDetails({
    this.userId,
    this.dateForSlot,
    this.isAttended,
    this.ageCategory,
    this.title,
    this.slotTime,
    this.image,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
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
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "dateForSlot": dateForSlot?.toIso8601String(),
        "isAttended": isAttended,
        "ageCategory": ageCategory?.toJson(),
        "title": title,
        "slotTime": slotTime?.toJson(),
        "image": image?.toJson(),
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
