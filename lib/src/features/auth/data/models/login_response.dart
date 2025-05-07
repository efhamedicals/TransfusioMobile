import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  bool? status;
  String? message;
  UserModel? user;
  String? otp;
  @JsonKey(name: "access_token")
  String? token;

  LoginResponse({this.status, this.message, this.user, this.otp, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
