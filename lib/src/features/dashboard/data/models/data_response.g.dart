// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  pslRequests:
      (json['psl_requests'] as List<dynamic>?)
          ?.map((e) => PslRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  pslRequestsCount: (json['psl_requests_count'] as num?)?.toInt(),
  paymentsCount: (json['payments_count'] as num?)?.toInt(),
  paymentsAmount: (json['payments_amount'] as num?)?.toInt(),
  averageHours: (json['average_hours'] as num?)?.toInt(),
);

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'psl_requests': instance.pslRequests?.map((e) => e.toJson()).toList(),
      'psl_requests_count': instance.pslRequestsCount,
      'payments_count': instance.paymentsCount,
      'payments_amount': instance.paymentsAmount,
      'average_hours': instance.averageHours,
    };
