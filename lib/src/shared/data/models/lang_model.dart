import 'package:transfusio/src/shared/domain/entities/Lang.dart';

class LangModel extends LangEntity {
  LangModel({super.code, super.name});

  Map<String, dynamic> toHashMap() {
    return {'code': code, 'name': name};
  }

  factory LangModel.fromMap(Map<String, dynamic> data) {
    return LangModel(code: data['code'], name: data['name']);
  }
}
