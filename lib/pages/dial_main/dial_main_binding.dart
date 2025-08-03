import 'package:get/get.dart';

import 'dial_main_logic.dart';

class DialMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DialMainLogic());
  }
}
