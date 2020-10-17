import 'package:device_preview/device_preview.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/main_page.dart';
import 'package:locally_flutter_app/views/registration.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MyApp()
      /*DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      )*/
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainPageVM>(
            create: (context)=>MainPageVM()),
        ChangeNotifierProvider<RegistrationPageVM>(
            create: (context)=>RegistrationPageVM())
      ],
      child: GetMaterialApp(
        //locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
        //builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
        title: 'Localy',
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          backgroundColor: Colors.white,
          name: 'assets/animations/splash.flr',
          next: (context) => RegistrationPage(),
          until: () => Future.delayed(Duration(seconds: 5)),
          startAnimation: 'intro',
        ),
      ),
    );
  }
}
