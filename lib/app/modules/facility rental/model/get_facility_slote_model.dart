// To parse this JSON data, do
//
//     final getFacilitySlotModel = getFacilitySlotModelFromJson(jsonString);

import 'dart:convert';

GetFacilitySlotModel getFacilitySlotModelFromJson(String str) =>
    GetFacilitySlotModel.fromJson(json.decode(str));

String getFacilitySlotModelToJson(GetFacilitySlotModel data) =>
    json.encode(data.toJson());

class GetFacilitySlotModel {
  String? message;
  List<Slot>? slots;

  GetFacilitySlotModel({
    this.message,
    this.slots,
  });

  factory GetFacilitySlotModel.fromJson(Map<String, dynamic> json) =>
      GetFacilitySlotModel(
        message: json["message"],
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
      };
}

class Slot {
  String? sloteId;
  Time? time;
  Date? date;
  bool? isBooked;
  Fees? fees;
  String? bookingId;
  String? bookingStatus;

  Slot({
    this.sloteId,
    this.time,
    this.date,
    this.isBooked,
    this.fees,
    this.bookingId,
    this.bookingStatus,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        sloteId: json["sloteId"],
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        isBooked: json["isBooked"],
        fees: json["fees"] == null ? null : Fees.fromJson(json["fees"]),
        bookingId: json["bookingId"],
        bookingStatus: json["bookingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "sloteId": sloteId,
        "time": time?.toJson(),
        "date": date?.toJson(),
        "isBooked": isBooked,
        "fees": fees?.toJson(),
        "bookingId": bookingId,
        "bookingStatus": bookingStatus,
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
