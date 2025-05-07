import 'package:get/get.dart';

class GlobalStrings {
  String get appName => _string('app_title');
  String get loading => _string('loading');
}

String _string(key) => 'gb.$key'.tr;
