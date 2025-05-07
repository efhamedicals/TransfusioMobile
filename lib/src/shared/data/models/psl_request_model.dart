import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/shared/data/models/psl_product_model.dart';
import 'package:transfusio/src/shared/domain/entities/psl_request.dart';

part 'psl_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PslRequestModel extends PslRequest {
  @override
  @JsonKey(name: 'id')
  int? get id => super.id;

  @override
  @JsonKey(name: 'reference')
  String? get reference => super.reference;

  @override
  @JsonKey(name: 'last_name')
  String? get lastName => super.lastName;

  @override
  @JsonKey(name: 'first_name')
  String? get firstName => super.firstName;

  @override
  @JsonKey(name: 'prescription')
  String? get prescription => super.prescription;

  @override
  @JsonKey(name: 'blood_report')
  String? get bloodReport => super.bloodReport;

  @override
  @JsonKey(name: 'end_verification')
  String? get endVerification => super.endVerification;

  @override
  @JsonKey(name: 'prescription_date')
  String? get prescriptionDate => super.prescriptionDate;

  @override
  @JsonKey(name: 'prescription_fullname')
  String? get prescriptionFullname => super.prescriptionFullname;

  @override
  @JsonKey(name: 'prescription_birth_date')
  String? get prescriptionBirthDate => super.prescriptionBirthDate;

  @override
  @JsonKey(name: 'prescription_age')
  String? get prescriptionAge => super.prescriptionAge;

  @override
  @JsonKey(name: 'prescription_gender')
  String? get prescriptionGender => super.prescriptionGender;

  @override
  @JsonKey(name: 'prescription_blood_type')
  String? get prescriptionBloodType => super.prescriptionBloodType;

  @override
  @JsonKey(name: 'prescription_blood_rh')
  String? get prescriptionBloodRh => super.prescriptionBloodRh;

  @override
  @JsonKey(name: 'prescription_diagnostic')
  String? get prescriptionDiagnostic => super.prescriptionDiagnostic;

  @override
  @JsonKey(name: 'prescription_substitution')
  int? get prescriptionSubstitution => super.prescriptionSubstitution;

  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => super.createdAt;

  @override
  @JsonKey(name: 'products')
  List<PslProductModel?>? get products =>
      super.products?.cast<PslProductModel?>();

  @override
  @JsonKey(name: 'payment')
  dynamic get payment => super.payment;

  @override
  @JsonKey(name: 'status')
  String? get status => super.status;

  PslRequestModel({
    super.id,
    super.lastName,
    super.firstName,
    super.reference,
    super.prescription,
    super.bloodReport,
    super.endVerification,
    super.prescriptionDate,
    super.prescriptionFullname,
    super.prescriptionBirthDate,
    super.prescriptionAge,
    super.prescriptionGender,
    super.prescriptionBloodType,
    super.prescriptionBloodRh,
    super.prescriptionDiagnostic,
    super.prescriptionSubstitution,
    super.createdAt,
    List<PslProductModel?>? super.products,
    super.payment,
    super.status,
  });

  /// Factory method for deserializing JSON
  factory PslRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PslRequestModelFromJson(json);

  /// Method for serializing to JSON
  Map<String, dynamic> toJson() => _$PslRequestModelToJson(this);
}
