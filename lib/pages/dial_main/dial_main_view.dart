import 'dart:math';

import 'package:bg_dial/pages/dial_main/first_item.dart';
import 'package:bg_dial/pages/dial_main/fourth_item.dart';
import 'package:bg_dial/pages/dial_main/second_item.dart';
import 'package:bg_dial/pages/dial_main/third_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
          );
        }),
        Obx(() {
          return SecondItem(
            showDay: controller.showDay.value,
          );
        }),
        Obx(() {
          return ThirdItem(
            showDay: controller.showDay.value,
          );
        }),
        Obx(() {
          return FourthItem(
            showDay: controller.showDay.value,
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
                })
              ].toColumn(),
              <Widget>[
                Obx(() {
                  return Visibility(
                      visible: controller.dialType.value == 0,
                      child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      ).decorated(
                          color: const Color(0xff292929),
                          borderRadius: BorderRadius.circular(20)));
                }),
                Obx(() {
                  return Visibility(
                      visible: controller.dialType.value == 1,
                      child: Container(
                        width: double.infinity,
                        height: 139,
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
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
                      ).decorated(
                          color: const Color(0xff292929),
                          borderRadius: BorderRadius.circular(20)));
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
                  .toColumn(mainAxisAlignment: MainAxisAlignment.end)
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
