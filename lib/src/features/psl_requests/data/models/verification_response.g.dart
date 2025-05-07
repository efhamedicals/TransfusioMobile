// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationResponse _$VerificationResponseFromJson(
  Map<String, dynamic> json,
) => VerificationResponse(
  found: json['found'] as bool?,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => VerificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  isAll: json['is_all'] as bool?,
);

Map<String, dynamic> _$VerificationResponseToJson(
  VerificationResponse instance,
) => <String, dynamic>{
  'found': instance.found,
  'is_all': instance.isAll,
  'data': instance.data?.map((e) => e.toJson()).toList(),
};
