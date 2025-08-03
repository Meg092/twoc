import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'dial_setting_logic.dart';

class DialSettingPage extends GetView<DialSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              width: double.infinity,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: <Widget>[
                const Text(
                  'Display date',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Switch(
                      value: controller.showDay.value,
                      activeTrackColor: Colors.green,
                      onChanged: (v) async {
                        controller.showDay.value = v;
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('showDay', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: const Color(0xff333333),
                    borderRadius: BorderRadius.circular(10))
                .marginOnly(bottom: 10),
            Container(
              width: double.infinity,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: <Widget>[
                const Text(
                  'App version',
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return Text(
                    controller.appVersion.value,
                    style: const TextStyle(color: Colors.grey),
                  );
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ).decorated(
                color: const Color(0xff333333),
                borderRadius: BorderRadius.circular(10))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
