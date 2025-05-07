import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/shared/domain/entities/psl_product.dart';

part 'psl_product_model.g.dart';

@JsonSerializable()
class PslProductModel extends PslProduct {
  @override
  @JsonKey(name: 'id')
  int? get id => super.id;

  @override
  @JsonKey(name: 'name')
  String? get name => super.name;

  @override
  @JsonKey(name: 'blood_type')
  String? get bloodType => super.bloodType;

  @override
  @JsonKey(name: 'blood_rh')
  String? get bloodRh => super.bloodRh;

  @override
  @JsonKey(name: 'count')
  int? get count => super.count;

  @override
  @JsonKey(name: 'psl_request_id')
  int? get pslRequestId => super.pslRequestId;

  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => super.createdAt;

  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt => super.updatedAt;

  PslProductModel({
    super.id,
    super.name,
    super.bloodType,
    super.bloodRh,
    super.count,
    super.pslRequestId,
    super.createdAt,
    super.updatedAt,
  });

  /// Factory method for deserializing JSON
  factory PslProductModel.fromJson(Map<String, dynamic> json) =>
      _$PslProductModelFromJson(json);

  /// Method for serializing to JSON
  Map<String, dynamic> toJson() => _$PslProductModelToJson(this);
}
