class SignInModel {
  String? message;
  String? encryptedToken;
  String? userId;

  SignInModel({
    this.message,
    this.encryptedToken,
    this.userId,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        message: json["message"],
        encryptedToken: json["encryptedToken"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "encryptedToken": encryptedToken,
        "userId": userId,
      };
}
