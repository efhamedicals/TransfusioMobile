import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

part 'psl_requests_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PslRequestsResponse {
  bool? status;
  String? message;
  @JsonKey(name: 'data')
  List<PslRequestModel>? pslRequests;

  PslRequestsResponse({this.pslRequests});

  factory PslRequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$PslRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PslRequestsResponseToJson(this);
}
