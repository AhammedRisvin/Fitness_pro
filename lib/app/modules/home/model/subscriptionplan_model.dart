import 'dart:convert';

class SubscriptionPlan {
  final String name;
  final double price;

  SubscriptionPlan({required this.name, required this.price});
}

// To parse this JSON data, do
//
//     final subscritptionPlanModel = subscritptionPlanModelFromJson(jsonString);

SubscritptionPlanModel subscritptionPlanModelFromJson(String str) =>
    SubscritptionPlanModel.fromJson(json.decode(str));

class SubscritptionPlanModel {
  String? message;
  List<PlanData>? planDatas;

  SubscritptionPlanModel({
    this.message,
    this.planDatas,
  });

  factory SubscritptionPlanModel.fromJson(Map<String, dynamic> json) =>
      SubscritptionPlanModel(
        message: json["message"],
        planDatas: json["planDatas"] == null
            ? []
            : List<PlanData>.from(
                json["planDatas"]!.map((x) => PlanData.fromJson(x))),
      );
}

class PlanData {
  String? id;
  String? planName;
  String? planType;
  String? planPrice;
  String? currencyType;
  String? description;
  bool? isActive;
  bool? isDelete;
  int? v;
  int? classes;
  bool? isMonthly;

  PlanData({
    this.id,
    this.planName,
    this.planType,
    this.planPrice,
    this.currencyType,
    this.description,
    this.isActive,
    this.isDelete,
    this.v,
    this.classes,
    this.isMonthly,
  });

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
        id: json["_id"],
        planName: json["planName"],
        planType: json["planType"],
        planPrice: json["planPrice"],
        currencyType: json["currencyType"],
        description: json["description"],
        isActive: json["isActive"],
        isDelete: json["isDelete"],
        v: json["__v"],
        classes: json["classes"],
        isMonthly: json["isMonthly"],
      );
}
