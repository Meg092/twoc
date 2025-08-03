import 'package:get/get.dart';

import 'dial_setting_logic.dart';

class DialSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DialSettingLogic());
  }
}
