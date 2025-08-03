import 'dart:math';

import 'package:bg_dial/pages/dial_main/dial_slider.dart';
import 'package:bg_dial/pages/dial_main/first_item.dart';
import 'package:bg_dial/pages/dial_main/fourth_item.dart';
import 'package:bg_dial/pages/dial_main/second_item.dart';
import 'package:bg_dial/pages/dial_main/third_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'dial_main_logic.dart';

class DialMainPage extends StatefulWidget {
  const DialMainPage({Key? key}) : super(key: key);

  @override
  State<DialMainPage> createState() => _DialMainPageState();
}

class _DialMainPageState extends State<DialMainPage> {
  DialMainLogic controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _dialType0Item(int index) {
    return <Widget>[
      Obx(() {
        return Visibility(
          visible: controller.currentIndex.value == index,
          child: const Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: Colors.white,
          ),
        );
      }),
      Image.asset(
        'assets/icon$index.webp',
        fit: BoxFit.cover,
      )
    ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween).gestures(
        onTap: () {
          controller.currentIndex.value = index;
          controller.update();
        });
  }

  Widget _dialType1Item(int index) {
    final items = [
      const FirstItem(
        isSmall: true,
      ),
      const SecondItem(
        isSmall: true,
      ),
      const ThirdItem(
        isSmall: true,
      ),
      const FourthItem(
        isSmall: true,
      )
    ];
    return <Widget>[
      Obx(() {
        return Visibility(
          visible: controller.currentIndex.value == index,
          child: const Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: Colors.white,
          ),
        );
      }),
      items[index]
    ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween).gestures(
        onTap: () {
          controller.currentIndex.value = index;
          controller.update();
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialMainLogic>(builder: (_) {
      final dialItems = [
        Obx(() {
          return FirstItem(
            showDay: controller.showDay.value,
            textColor: controller.hourMinuteColor,
            fontSize: controller.fontSize.value,
          );
        }),
        Obx(() {
          return SecondItem(
            showDay: controller.showDay.value,
            textColor: controller.hourMinuteColor,
            fontSize: controller.fontSize.value,
          );
        }),
        Obx(() {
          return ThirdItem(
            showDay: controller.showDay.value,
            textColor: controller.hourMinuteColor,
            fontSize: controller.fontSize.value,
          );
        }),
        Obx(() {
          return FourthItem(
            showDay: controller.showDay.value,
            textColor: controller.hourMinuteColor,
            fontSize: controller.fontSize.value,
          );
        }),
      ];
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: null,
          actions: [
            const Icon(
              Icons.settings,
              size: 30,
              color: Color(0xffd3d3d3),
            ).marginOnly(right: 20).gestures(onTap: () {
              Get.toNamed('/dial_setting')?.then((_) {
                controller.getData();
              });
            })
          ],
        ),
        body: Obx(() {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: controller.dialType.value == 0
                        ? AssetImage(
                        'assets/bg${controller.dialType.value}.webp')
                        : const AssetImage('assets/otherBG.webp'),
                    fit: BoxFit.fill)),
            child: SafeArea(
                child: <Widget>[
                  <Widget>[
                    Obx(() {
                      return Visibility(
                        visible: controller.dialType.value == 0 &&
                            controller.showDay.value,
                        child: Obx(() {
                          return Text(
                            controller.currentTimeStr.value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                      );
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() {
                      return Visibility(
                          visible: controller.dialType.value == 0,
                          child: <Widget>[
                            Obx(() {
                              return Image.asset(
                                'assets/dial${controller.currentIndex.value}.webp',
                                fit: BoxFit.cover,
                              );
                            }),
                            Positioned(
                              top: controller
                                  .minuteTop[controller.currentIndex.value],
                              child: Obx(() {
                                return ClockHand(
                                  imagePath:
                                  'assets/minute${controller.currentIndex.value}.webp',
                                  angle: controller.calculateMinuteAngle(),
                                );
                              }),
                            ),
                            Positioned(
                              top:
                              controller.hourTop[controller.currentIndex.value],
                              child: Obx(() {
                                return ClockHand(
                                  imagePath:
                                  'assets/hour${controller.currentIndex.value}.webp',
                                  angle: controller.calculateHourAngle(),
                                );
                              }),
                            ),
                            Obx(() {
                              return Image.asset(
                                'assets/point${controller.currentIndex.value}.webp',
                                fit: BoxFit.cover,
                              ).marginOnly(
                                  top: controller.currentIndex.value == 1 ? 30 : 0);
                            }),
                          ].toStack(alignment: Alignment.center));
                    }),
                    Obx(() {
                      return Visibility(
                          visible: controller.dialType.value == 1,
                          child: dialItems[controller.currentIndex.value]
                              .marginSymmetric(horizontal: 20));
                    }),
                  ].toColumn(),
                  <Widget>[
                    Obx(() {
                      return Visibility(
                          visible: controller.dialType.value == 0 &&
                              controller.showBox.value == true,
                          child: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 139,
                              padding: const EdgeInsets.all(12),
                              child: <Widget>[
                                _dialType0Item(0),
                                const SizedBox(
                                  width: 10,
                                ),
                                _dialType0Item(1),
                                const SizedBox(
                                  width: 10,
                                ),
                                _dialType0Item(2),
                                const SizedBox(
                                  width: 10,
                                ),
                                _dialType0Item(3),
                              ].toRow(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                            ).decorated(
                                color: const Color(0xff292929),
                                borderRadius: BorderRadius.circular(20)),
                            Positioned(
                                top: 3,
                                left: 3,
                                child: const Icon(
                                  Icons.keyboard_double_arrow_down_outlined,
                                  size: 25,
                                  color: Colors.white,
                                ).gestures(onTap: () {
                                  controller.showBox.value =
                                  !controller.showBox.value;
                                }))
                          ].toStack());
                    }),
                    Obx(() {
                      return Visibility(
                          visible: controller.dialType.value == 1 &&
                              controller.showBox.value == true,
                          child: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 300,
                              padding: const EdgeInsets.all(12),
                              child: <Widget>[
                                SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: <Widget>[
                                    _dialType1Item(0),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    _dialType1Item(1),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    _dialType1Item(2),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    _dialType1Item(3),
                                  ].toRow(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Text color',
                                  style: TextStyle(color: Colors.white),
                                ),
                                <Widget>[
                                  const SizedBox(
                                    width: 60,
                                    child: Text(
                                      'Red',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(child: Obx(() {
                                    return DialSlider(0, controller.redValue.value,
                                            (v) async {
                                          controller.redValue.value = v;
                                          controller.hourMinuteColor = Color.fromARGB(
                                              255,
                                              controller.redValue.value,
                                              controller.greenValue.value,
                                              controller.blueValue.value);
                                          final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          await prefs.setStringList('hourMinuteColor', [
                                            controller.redValue.value.toString(),
                                            controller.greenValue.value.toString(),
                                            controller.blueValue.value.toString()
                                          ]);
                                          controller.update();
                                        });
                                  }))
                                ].toRow(),
                                <Widget>[
                                  const SizedBox(
                                    width: 60,
                                    child: Text(
                                      'Green',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(child: Obx(() {
                                    return DialSlider(
                                        1, controller.greenValue.value, (v) async {
                                      controller.greenValue.value = v;
                                      controller.hourMinuteColor = Color.fromARGB(
                                          255,
                                          controller.redValue.value,
                                          controller.greenValue.value,
                                          controller.blueValue.value);
                                      final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                      await prefs.setStringList('hourMinuteColor', [
                                        controller.redValue.value.toString(),
                                        controller.greenValue.value.toString(),
                                        controller.blueValue.value.toString()
                                      ]);
                                      controller.update();
                                    });
                                  }))
                                ].toRow(),
                                <Widget>[
                                  const SizedBox(
                                    width: 60,
                                    child: Text(
                                      'Blue',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(child: Obx(() {
                                    return DialSlider(2, controller.blueValue.value,
                                            (v) async {
                                          controller.blueValue.value = v;
                                          controller.hourMinuteColor = Color.fromARGB(
                                              255,
                                              controller.redValue.value,
                                              controller.greenValue.value,
                                              controller.blueValue.value);
                                          final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          await prefs.setStringList('hourMinuteColor', [
                                            controller.redValue.value.toString(),
                                            controller.greenValue.value.toString(),
                                            controller.blueValue.value.toString()
                                          ]);
                                          controller.update();
                                        });
                                  }))
                                ].toRow(),
                                const Text(
                                  'Font size',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.white,
                                    inactiveTrackColor: Colors.white.withOpacity(0.4),
                                    thumbColor: Colors.white,
                                    overlayColor: const Color(0xff3e3e3e),
                                    valueIndicatorColor: Colors.white,
                                    trackHeight: 4,
                                    showValueIndicator: ShowValueIndicator.always,
                                  ),
                                  child: Obx(() {
                                    return Slider(
                                      value: controller.fontSize.value,
                                      min: 70,
                                      max: 90,
                                      onChanged: (v) async {
                                        controller.fontSize.value = v;
                                        final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                        await prefs.setDouble('fontSize', v);
                                        controller.update();
                                      },
                                    );
                                  }),
                                )
                              ].toColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start),
                            ).decorated(
                                color: const Color(0xff292929),
                                borderRadius: BorderRadius.circular(20)),
                            Positioned(
                                top: 3,
                                left: 3,
                                child: const Icon(
                                  Icons.keyboard_double_arrow_down_outlined,
                                  size: 25,
                                  color: Colors.white,
                                ).gestures(onTap: () {
                                  controller.showBox.value =
                                  !controller.showBox.value;
                                }))
                          ].toStack());
                    }),
                    Obx(() {
                      return Visibility(
                          visible: !controller.showBox.value,
                          child: const Icon(
                            Icons.keyboard_double_arrow_down_outlined,
                            size: 25,
                            color: Colors.white,
                          ).gestures(onTap: () {
                            controller.showBox.value = !controller.showBox.value;
                          }));
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 66,
                      padding: const EdgeInsets.all(5),
                      child: <Widget>[
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.5),
                                  color: controller.dialType.value == 0
                                      ? const Color(0xff292929)
                                      : Colors.transparent),
                              alignment: Alignment.center,
                              child: Text(
                                'Watch clock',
                                style: TextStyle(
                                    color: controller.dialType.value == 0
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ).gestures(onTap: () {
                              controller.dialType.value = 0;
                              controller.update();
                            })),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.5),
                                  color: controller.dialType.value == 1
                                      ? const Color(0xff292929)
                                      : Colors.transparent),
                              alignment: Alignment.center,
                              child: Text(
                                'Digital clock',
                                style: TextStyle(
                                    color: controller.dialType.value == 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ).gestures(onTap: () {
                              controller.dialType.value = 1;
                              controller.update();
                            }))
                      ].toRow(),
                    ).decorated(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(33))
                  ]
                      .toColumn(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start)
                      .marginSymmetric(horizontal: 20)
                ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)),
          );
        }),
      );
    });
  }
}

class ClockHand extends StatelessWidget {
  final String imagePath;
  final double angle;

  const ClockHand({
    super.key,
    required this.imagePath,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateZ(angle * pi / 180),
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
