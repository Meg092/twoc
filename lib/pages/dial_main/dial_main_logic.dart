import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialMainLogic extends GetxController {
  var dialType = 0.obs;
  var currentIndex = 0.obs;
  var showBox = true.obs;
  var hourMinuteColor = const Color(0xffffffff);
  var redValue = 0.obs;
  var greenValue = 0.obs;
  var blueValue = 0.obs;
  var fontSize = 90.0.obs;

  var currentTime = DateTime.now().obs;
  var currentTimeStr = ''.obs;

  var showDay = true.obs;

  List<double> hourTop = [58, 81, 85, 73];
  List<double> minuteTop = [45, 70, 72, 68];

  Timer? _timer;

  void startTimer() {
    getDate();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
  }

  void getDate() {
    final now = DateTime.now();
    currentTime.value = now;
    currentTimeStr.value = DateFormat("MMMM d',' yyyy").format(now);
    update();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showDay.value = prefs.getBool('showDay') ?? true;
    final hourMinuteList = prefs.getStringList('hourMinuteColor') ?? [];
    redValue.value = int.parse(hourMinuteList[0]);
    greenValue.value = int.parse(hourMinuteList[1]);
    blueValue.value = int.parse(hourMinuteList[2]);
    hourMinuteColor = Color.fromARGB(255, redValue.value, greenValue.value, blueValue.value);
    fontSize.value = prefs.getDouble('fontSize') ?? 90.0;
    update();
  }

  double calculateHourAngle() {
    return (currentTime.value.hour % 12) * 30 + currentTime.value.minute * 0.5;
  }

  double calculateMinuteAngle() {
    return currentTime.value.minute * 6 + currentTime.value.second * 0.1;
  }

  double calculateSecondAngle() {
    return currentTime.value.second * 6 + currentTime.value.millisecond * 0.006;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getData();
    startTimer();
    super.onInit();
  }
}
