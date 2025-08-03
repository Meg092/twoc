import 'package:get/get.dart';

import 'dial_edit_logic.dart';

class DialEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      DialEditLogic(),
      permanent: true,
    );
  }
}
