// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_psl_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPslRequestResponse _$AddPslRequestResponseFromJson(
  Map<String, dynamic> json,
) => AddPslRequestResponse(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  pslRequest:
      json['psl_request'] == null
          ? null
          : PslRequestModel.fromJson(
            json['psl_request'] as Map<String, dynamic>,
          ),
  verification:
      json['verification'] == null
          ? null
          : VerificationResponse.fromJson(
            json['verification'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$AddPslRequestResponseToJson(
  AddPslRequestResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'psl_request': instance.pslRequest?.toJson(),
  'verification': instance.verification?.toJson(),
};
