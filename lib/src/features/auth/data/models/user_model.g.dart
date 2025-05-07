// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt(),
  firstname: json['first_name'] as String?,
  lastname: json['last_name'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  emailVerify: (json['email_verify'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  password: json['password'] as String?,
  address: json['address'] as String?,
  avatar: json['avatar'] as String?,
  status: (json['status'] as num?)?.toInt(),
  phoneVerify: (json['phone_verify'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'first_name': instance.firstname,
  'last_name': instance.lastname,
  'email': instance.email,
  'email_verify': instance.emailVerify,
  'phone_verify': instance.phoneVerify,
  'phone': instance.phone,
  'password': instance.password,
  'address': instance.address,
  'avatar': instance.avatar,
  'status': instance.status,
};
