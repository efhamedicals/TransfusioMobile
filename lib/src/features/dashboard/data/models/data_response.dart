import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

part 'data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DataResponse {
  bool? status;
  String? message;
  @JsonKey(name: "psl_requests")
  List<PslRequestModel>? pslRequests = [];
  @JsonKey(name: "psl_requests_count")
  int? pslRequestsCount = 0;
  @JsonKey(name: "payments_count")
  int? paymentsCount = 0;
  @JsonKey(name: "payments_amount")
  int? paymentsAmount = 0;
  @JsonKey(name: "average_hours")
  String? averageHours = "";

  DataResponse({
    this.status,
    this.message,
    this.pslRequests,
    this.pslRequestsCount,
    this.paymentsCount,
    this.paymentsAmount,
    this.averageHours,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}
