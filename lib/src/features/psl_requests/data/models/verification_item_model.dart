import 'package:json_annotation/json_annotation.dart';

part 'verification_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VerificationItem {
  int? id;
  int? count;
  List<dynamic>? bloodBanks;
  int? amount;
  bool? all;

  VerificationItem({
    this.id,
    this.count,
    this.bloodBanks,
    this.amount,
    this.all,
  });

  factory VerificationItem.fromJson(Map<String, dynamic> json) =>
      _$VerificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationItemToJson(this);
}
