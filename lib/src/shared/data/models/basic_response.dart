import 'package:json_annotation/json_annotation.dart';

part 'basic_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicResponse {
  bool? status;
  String? message;
  @JsonKey(name: 'user_id')
  int? userId;

  BasicResponse({this.status, this.message, this.userId});

  factory BasicResponse.fromJson(Map<String, dynamic> json) =>
      _$BasicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasicResponseToJson(this);
}
