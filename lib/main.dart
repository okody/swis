import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:swis/Core/Constants/theme_constants.dart';
import 'package:swis/Core/Utils/helpers/binding.dart';
import 'package:swis/Core/Utils/helpers/local_notification.dart';
import 'package:swis/Core/Utils/translation.dart';
import 'package:swis/Screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return GetMaterialApp(
        title: 'SIWS',
        theme: kAPP_THEME,
        debugShowCheckedModeBanner: false,
        initialBinding: MainBinding(),
        translations: Translation(),
        locale: Locale(box.read("locale") ?? "en"),
        fallbackLocale: const Locale("en"),
        home: const SplashScreen());
  }
}
