// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationItem _$VerificationItemFromJson(Map<String, dynamic> json) =>
    VerificationItem(
      id: (json['id'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      bloodBanks: json['bloodBanks'] as List<dynamic>?,
      amount: (json['amount'] as num?)?.toInt(),
      all: json['all'] as bool?,
    );

Map<String, dynamic> _$VerificationItemToJson(VerificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'bloodBanks': instance.bloodBanks,
      'amount': instance.amount,
      'all': instance.all,
    };
