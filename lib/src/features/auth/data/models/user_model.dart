import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {
  @override
  @JsonKey(name: 'id')
  int? get id => super.id;

  @override
  @JsonKey(name: 'first_name')
  String? get firstname => super.firstname;

  @override
  @JsonKey(name: 'last_name')
  String? get lastname => super.lastname;

  @override
  @JsonKey(name: 'email')
  String? get email => super.email;

  @override
  @JsonKey(name: 'email_verify')
  int? get emailVerify => super.emailVerify;

  @override
  @JsonKey(name: 'phone_verify')
  int? get phoneVerify => super.phoneVerify;

  @override
  @JsonKey(name: 'phone')
  String? get phone => super.phone;

  @override
  @JsonKey(name: 'password')
  String? get password => super.password;

  @override
  @JsonKey(name: 'address')
  String? get address => super.address;

  @override
  @JsonKey(name: 'avatar')
  String? get avatar => super.avatar;

  @override
  @JsonKey(name: 'status')
  int? get status => super.status;

  const UserModel({
    super.id,
    super.firstname,
    super.lastname,
    super.name,
    super.email,
    super.emailVerify,
    super.phone,
    super.password,
    super.address,
    super.avatar,
    super.status,
    super.phoneVerify,
  });

  /// Factory method for deserializing JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Method for serializing to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
