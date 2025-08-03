import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class ThirdItem extends StatefulWidget {
  const ThirdItem({this.isSmall = false, this.showDay = true, Key? key}) : super(key: key);
  final bool isSmall;
  final bool showDay;

  @override
  State<ThirdItem> createState() => _ThirdItemState();
}

class _ThirdItemState extends State<ThirdItem> {
  Timer? _timer;

  var dayStr = ''.obs;
  var hourMinuteStr = ''.obs;
  var apmStr = ''.obs;
  var weekdayStr = ''.obs;

  void startTimer() {
    getDate();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
  }

  void getDate() {
    final now = DateTime.now();
    dayStr.value = DateFormat("MMMM d','yyyy").format(now);
    hourMinuteStr.value = DateFormat('hh:mm').format(now);
    apmStr.value = DateFormat('a').format(now).toUpperCase();
    weekdayStr.value = DateFormat('EEEE').format(now);
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Visibility(
          visible: widget.isSmall ? true : widget.showDay,
          child: Obx(() {
            return Text(
              dayStr.value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.isSmall ? 6 : 20,
              ),
            );
          })),
      <Widget>[
        Obx(() {
          return Text(
            hourMinuteStr.value,
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.isSmall ? 26 : 85,
                fontWeight: FontWeight.bold),
          );
        }),
        Obx(() {
          return Text(
            apmStr.value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.isSmall ? 12 : 50,
            ),
          );
        })
      ].toRow(),
      Obx(() {
        return Text(
          weekdayStr.value,
          style: TextStyle(
              color: Colors.white,
              fontSize: widget.isSmall ? 6 : 20,
              fontWeight: FontWeight.bold),
        );
      }),
    ].toColumn();
  }
}
