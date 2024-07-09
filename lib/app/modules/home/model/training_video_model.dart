class TrainingVideosModel {
  String? message;
  List<Response>? response;

  TrainingVideosModel({
    this.message,
    this.response,
  });

  factory TrainingVideosModel.fromJson(Map<String, dynamic> json) =>
      TrainingVideosModel(
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"]!.map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  String? categoryName;
  List<TrainingVideo>? trainingVideos;

  Response({
    this.categoryName,
    this.trainingVideos,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        categoryName: json["categoryName"],
        trainingVideos: json["trainingVideos"] == null
            ? []
            : List<TrainingVideo>.from(
                json["trainingVideos"]!.map((x) => TrainingVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "trainingVideos": trainingVideos == null
            ? []
            : List<dynamic>.from(trainingVideos!.map((x) => x.toJson())),
      };
}

class TrainingVideo {
  ThumpImage? thumpImage;
  String? id;
  String? videoName;
  String? videoCategory;
  String? videoUrl;
  int? v;

  TrainingVideo({
    this.thumpImage,
    this.id,
    this.videoName,
    this.videoCategory,
    this.videoUrl,
    this.v,
  });

  factory TrainingVideo.fromJson(Map<String, dynamic> json) => TrainingVideo(
        thumpImage: json["thumpImage"] == null
            ? null
            : ThumpImage.fromJson(json["thumpImage"]),
        id: json["_id"],
        videoName: json["videoName"],
        videoCategory: json["videoCategory"],
        videoUrl: json["videoUrl"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "thumpImage": thumpImage?.toJson(),
        "_id": id,
        "videoName": videoName,
        "videoCategory": videoCategory,
        "videoUrl": videoUrl,
        "__v": v,
      };
}

class ThumpImage {
  String? url;
  String? uniqueName;

  ThumpImage({
    this.url,
    this.uniqueName,
  });

  factory ThumpImage.fromJson(Map<String, dynamic> json) => ThumpImage(
        url: json["Url"],
        uniqueName: json["uniqueName"],
      );

  Map<String, dynamic> toJson() => {
        "Url": url,
        "uniqueName": uniqueName,
      };
}
