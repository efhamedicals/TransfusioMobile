import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/psl_requests/data/models/verification_item_model.dart';

part 'verification_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VerificationResponse {
  bool? found;
  @JsonKey(name: 'is_all')
  bool? isAll;
  List<VerificationItem>? data;

  VerificationResponse({this.found, this.data, this.isAll});

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationResponseToJson(this);
}
