import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/psl_requests/data/models/verification_response.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

part 'add_psl_request_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AddPslRequestResponse {
  bool? status;
  String? message;
  @JsonKey(name: 'psl_request')
  PslRequestModel? pslRequest;
  @JsonKey(name: 'verification')
  VerificationResponse? verification;

  AddPslRequestResponse({
    this.status,
    this.message,
    this.pslRequest,
    this.verification,
  });

  factory AddPslRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPslRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPslRequestResponseToJson(this);
}
