// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psl_requests_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PslRequestsResponse _$PslRequestsResponseFromJson(Map<String, dynamic> json) =>
    PslRequestsResponse(
        pslRequests:
            (json['data'] as List<dynamic>?)
                ?.map(
                  (e) => PslRequestModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
      )
      ..status = json['status'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PslRequestsResponseToJson(
  PslRequestsResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.pslRequests?.map((e) => e.toJson()).toList(),
};
