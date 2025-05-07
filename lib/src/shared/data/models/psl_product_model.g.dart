// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psl_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PslProductModel _$PslProductModelFromJson(Map<String, dynamic> json) =>
    PslProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      bloodType: json['blood_type'] as String?,
      bloodRh: json['blood_rh'] as String?,
      count: (json['count'] as num?)?.toInt(),
      pslRequestId: (json['psl_request_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PslProductModelToJson(PslProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'blood_type': instance.bloodType,
      'blood_rh': instance.bloodRh,
      'count': instance.count,
      'psl_request_id': instance.pslRequestId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
