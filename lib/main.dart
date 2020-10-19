import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/main_page.dart';
import 'package:locally_flutter_app/views/registration.dart';
import 'package:locally_flutter_app/views/widgets/splash_with_flare.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp()
      /*DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      )*/
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppStartingPoint();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }

}
class AppStartingPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainPageVM>(
            create: (context)=>MainPageVM()),
        ChangeNotifierProvider<RegistrationPageVM>(
            create: (context)=>RegistrationPageVM()),
        ChangeNotifierProvider<HomePageVM>(
            create: (context)=>HomePageVM())

      ],
      child: GetMaterialApp(
        //locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
        //builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
        title: 'Localy',
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          backgroundColor: Colors.white,
          name: 'assets/animations/splash.flr',
          next: RegistrationPage(),
          until: () => Future.delayed(Duration(seconds: 3)),
          startAnimation: 'intro',
          transitionDuration: Duration(seconds: 2),
          transition: Transition.fadeIn,
        ),
      ),
    );
  }
}

