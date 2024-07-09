class GetBranchModel {
  String? message;
  List<BranchDatum>? branchData;

  GetBranchModel({
    this.message,
    this.branchData,
  });

  factory GetBranchModel.fromJson(Map<String, dynamic> json) => GetBranchModel(
        message: json["message"],
        branchData: json["branchData"] == null
            ? []
            : List<BranchDatum>.from(
                json["branchData"]!.map((x) => BranchDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "branchData": branchData == null
            ? []
            : List<dynamic>.from(branchData!.map((x) => x.toJson())),
      };
}

class BranchDatum {
  Address? address;
  String? id;
  String? branchName;
  int? v;
  bool? isDelete;

  BranchDatum({
    this.address,
    this.id,
    this.branchName,
    this.v,
    this.isDelete,
  });

  factory BranchDatum.fromJson(Map<String, dynamic> json) => BranchDatum(
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
