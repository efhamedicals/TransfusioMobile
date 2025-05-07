import 'package:transfusio/src/shared/domain/entities/psl_product.dart';

class PslRequest {
  final int? id;
  final String? lastName;
  final String? reference;
  final String? firstName;
  final String? prescription;
  final String? bloodReport;
  final String? endVerification;
  final String? prescriptionDate;
  final String? prescriptionFullname;
  final String? prescriptionBirthDate;
  final String? prescriptionAge;
  final String? prescriptionGender;
  final String? prescriptionBloodType;
  final String? prescriptionBloodRh;
  final String? prescriptionDiagnostic;
  final int? prescriptionSubstitution;
  final String? createdAt;
  final List<PslProduct?>? products;
  final dynamic payment;
  final String? status;

  PslRequest({
    this.id,
    this.lastName,
    this.firstName,
    this.prescription,
    this.bloodReport,
    this.endVerification,
    this.prescriptionDate,
    this.prescriptionFullname,
    this.prescriptionBirthDate,
    this.prescriptionAge,
    this.prescriptionGender,
    this.prescriptionBloodType,
    this.prescriptionBloodRh,
    this.prescriptionDiagnostic,
    this.prescriptionSubstitution,
    this.createdAt,
    this.products,
    this.payment,
    this.status,
    this.reference,
  });
}
