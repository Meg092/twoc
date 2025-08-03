import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class FirstItem extends StatefulWidget {
  const FirstItem({this.isSmall = false, this.showDay = true, Key? key})
      : super(key: key);
  final bool isSmall;
  final bool showDay;

  @override
  State<FirstItem> createState() => _FirstItemState();
}

class _FirstItemState extends State<FirstItem> {
  Timer? _timer;

  var dayStr = ''.obs;
  var hourMinuteStr = ''.obs;
  var apmStr = ''.obs;

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
      Container(
        padding: EdgeInsets.symmetric(vertical: widget.isSmall ? 10 : 20),
        child: Obx(() {
          return Text(
            hourMinuteStr.value,
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.isSmall ? 26 : 100,
                fontWeight: FontWeight.bold),
          );
        }),
      ),
      Positioned(
          bottom: widget.isSmall ? 0 : -20,
          right: 0,
          child: Obx(() {
            return Text(
              apmStr.value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.isSmall ? 12 : 60,
              ),
            );
          })),
      Positioned(
          top: 0,
          left: 0,
          child: Visibility(
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
              })))
    ].toStack();
  }
}
