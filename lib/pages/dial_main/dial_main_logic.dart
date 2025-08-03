import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialMainLogic extends GetxController {
  var dialType = 0.obs;
  var currentIndex = 0.obs;

  var currentTime = DateTime.now().obs;
  var currentTimeStr = ''.obs;

  var showDay = true.obs;

  List<double> hourTop = [58,81,85,73];
  List<double> minuteTop = [45,70,72,68];

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
