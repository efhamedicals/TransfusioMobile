// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psl_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PslRequestModel _$PslRequestModelFromJson(Map<String, dynamic> json) =>
    PslRequestModel(
      id: (json['id'] as num?)?.toInt(),
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      reference: json['reference'] as String?,
      prescription: json['prescription'] as String?,
      bloodReport: json['blood_report'] as String?,
      endVerification: json['end_verification'] as String?,
      prescriptionDate: json['prescription_date'] as String?,
      prescriptionFullname: json['prescription_fullname'] as String?,
      prescriptionBirthDate: json['prescription_birth_date'] as String?,
      prescriptionAge: json['prescription_age'] as String?,
      prescriptionGender: json['prescription_gender'] as String?,
      prescriptionBloodType: json['prescription_blood_type'] as String?,
      prescriptionBloodRh: json['prescription_blood_rh'] as String?,
      prescriptionDiagnostic: json['prescription_diagnostic'] as String?,
      prescriptionSubstitution:
          (json['prescription_substitution'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (e) =>
                    e == null
                        ? null
                        : PslProductModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      payment: json['payment'],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PslRequestModelToJson(PslRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'prescription': instance.prescription,
      'blood_report': instance.bloodReport,
      'end_verification': instance.endVerification,
      'prescription_date': instance.prescriptionDate,
      'prescription_fullname': instance.prescriptionFullname,
      'prescription_birth_date': instance.prescriptionBirthDate,
      'prescription_age': instance.prescriptionAge,
      'prescription_gender': instance.prescriptionGender,
      'prescription_blood_type': instance.prescriptionBloodType,
      'prescription_blood_rh': instance.prescriptionBloodRh,
      'prescription_diagnostic': instance.prescriptionDiagnostic,
      'prescription_substitution': instance.prescriptionSubstitution,
      'created_at': instance.createdAt,
      'products': instance.products?.map((e) => e?.toJson()).toList(),
      'payment': instance.payment,
      'status': instance.status,
    };
