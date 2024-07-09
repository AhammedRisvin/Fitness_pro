class GetBookedFacilityModel {
  String? message;
  List<SlotesWithBooking>? slotesWithBookings;

  GetBookedFacilityModel({
    this.message,
    this.slotesWithBookings,
  });

  factory GetBookedFacilityModel.fromJson(Map<String, dynamic> json) =>
      GetBookedFacilityModel(
        message: json["message"],
        slotesWithBookings: json["slotesWithBookings"] == null
            ? []
            : List<SlotesWithBooking>.from(json["slotesWithBookings"]!
                .map((x) => SlotesWithBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "slotesWithBookings": slotesWithBookings == null
            ? []
            : List<dynamic>.from(slotesWithBookings!.map((x) => x.toJson())),
      };
}

class SlotesWithBooking {
  String? branch;
  SloteFees? sloteFees;
  SloteTime? sloteTime;
  List<Booking>? bookings;
  String? facility;
  Image? image;

  SlotesWithBooking({
    this.branch,
    this.sloteFees,
    this.sloteTime,
    this.bookings,
    this.facility,
    this.image,
  });

  factory SlotesWithBooking.fromJson(Map<String, dynamic> json) =>
      SlotesWithBooking(
        branch: json["branch"],
        sloteFees: json["sloteFees"] == null
            ? null
            : SloteFees.fromJson(json["sloteFees"]),
        sloteTime: json["sloteTime"] == null
            ? null
            : SloteTime.fromJson(json["sloteTime"]),
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
        facility: json["facility"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "branch": branch,
        "sloteFees": sloteFees?.toJson(),
        "sloteTime": sloteTime?.toJson(),
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
        "facility": facility,
        "image": image?.toJson(),
      };
}

class Booking {
  String? userId;
  String? bookingStatus;
  DateTime? dateForSlot;
  String? id;

  Booking({
    this.userId,
    this.bookingStatus,
    this.dateForSlot,
    this.id,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
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

class SloteFees {
  int? amount;
  String? currency;

  SloteFees({
    this.amount,
    this.currency,
  });

  factory SloteFees.fromJson(Map<String, dynamic> json) => SloteFees(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}

class SloteTime {
  String? startTime;
  String? endTime;

  SloteTime({
    this.startTime,
    this.endTime,
  });

  factory SloteTime.fromJson(Map<String, dynamic> json) => SloteTime(
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
      };
}
