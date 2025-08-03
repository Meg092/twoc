import 'package:bg_dial/pages/dial_main/dial_main_binding.dart';
import 'package:bg_dial/pages/dial_main/dial_main_view.dart';
import 'package:bg_dial/pages/dial_setting/dial_setting_binding.dart';
import 'package:bg_dial/pages/dial_setting/dial_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xff0d1011);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final showDay = prefs.getBool('showDay') ;
  if (showDay == null) {
    await prefs.setBool('showDay', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: TwoC,
      initialRoute: '/dial_main',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> TwoC = [
  GetPage(name: '/dial_main', page: () => const DialMainPage(), binding: DialMainBinding()),
  GetPage(name: '/dial_setting', page: () => DialSettingPage(), binding: DialSettingBinding()),
];