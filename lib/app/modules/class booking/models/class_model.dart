class GetClassesModel {
  String? message;
  List<ClassDatum>? classData;
  bool? userPlan;

  GetClassesModel({
    this.message,
    this.classData,
    this.userPlan,
  });

  factory GetClassesModel.fromJson(Map<String, dynamic> json) =>
      GetClassesModel(
        message: json["message"],
        classData: json["classData"] == null
            ? []
            : List<ClassDatum>.from(
                json["classData"]!.map((x) => ClassDatum.fromJson(x))),
        userPlan: json["userPlan"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "classData": classData == null
            ? []
            : List<dynamic>.from(classData!.map((x) => x.toJson())),
        "userPlan": userPlan,
      };
}

class ClassDatum {
  String? id;
  ClassData? classData;
  List<Slote>? slotes;

  ClassDatum({
    this.id,
    this.classData,
    this.slotes,
  });

  factory ClassDatum.fromJson(Map<String, dynamic> json) => ClassDatum(
        id: json["_id"],
        classData: json["classData"] == null
            ? null
            : ClassData.fromJson(json["classData"]),
        slotes: json["slotes"] == null
            ? []
            : List<Slote>.from(json["slotes"]!.map((x) => Slote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "classData": classData?.toJson(),
        "slotes": slotes == null
            ? []
            : List<dynamic>.from(slotes!.map((x) => x.toJson())),
      };
}

class ClassData {
  String? title;
  String? classType;
  AgeCategory? ageCategory;
  int? availableSloteCount;
  String? description;
  ClassImage? image;
  Branch? branch;

  ClassData({
    this.title,
    this.classType,
    this.ageCategory,
    this.availableSloteCount,
    this.description,
    this.image,
    this.branch,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) => ClassData(
        title: json["title"],
        classType: json["classType"],
        ageCategory: json["ageCategory"] == null
            ? null
            : AgeCategory.fromJson(json["ageCategory"]),
        availableSloteCount: json["availableSloteCount"],
        description: json["description"],
        image:
            json["image"] == null ? null : ClassImage.fromJson(json["image"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "classType": classType,
        "ageCategory": ageCategory?.toJson(),
        "availableSloteCount": availableSloteCount,
        "description": description,
        "image": image?.toJson(),
        "branch": branch?.toJson(),
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

class Branch {
  String? branchName;
  Address? address;

  Branch({
    this.branchName,
    this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchName: json["branchName"],
        address:
            json["Address"] == null ? null : Address.fromJson(json["Address"]),
      );

  Map<String, dynamic> toJson() => {
        "branchName": branchName,
        "Address": address?.toJson(),
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

class ClassImage {
  String? url;

  ClassImage({
    this.url,
  });

  factory ClassImage.fromJson(Map<String, dynamic> json) => ClassImage(
        url: json["Url"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
      };
}

class Slote {
  String? sloteId;
  Time? time;
  Date? date;
  bool? isSloteCompleted;
  int? availableSlote;

  Slote({
    this.sloteId,
    this.time,
    this.date,
    this.isSloteCompleted,
    this.availableSlote,
  });

  factory Slote.fromJson(Map<String, dynamic> json) => Slote(
        sloteId: json["sloteId"],
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        date: json["date"] == null ? null : Date.fromJson(json["date"]),
        isSloteCompleted: json["isSloteCompleted"],
        availableSlote: json["availableSlote"],
      );

  Map<String, dynamic> toJson() => {
        "sloteId": sloteId,
        "time": time?.toJson(),
        "date": date?.toJson(),
        "isSloteCompleted": isSloteCompleted,
        "availableSlote": availableSlote,
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
