import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialSettingLogic extends GetxController {

  var appVersion = ''.obs;
  var showDay = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showDay.value = prefs.getBool('showDay') ?? true;
    super.onInit();
  }

}
