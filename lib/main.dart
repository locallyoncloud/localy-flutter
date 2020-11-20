
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locally_flutter_app/service_locator.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/registration_page/registration.dart';
import 'package:locally_flutter_app/views/widgets/splash_with_flare.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) =>   runApp(
      MyApp()
    /*DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      )*/
  )
  );
}
final FirebaseAuth fAuth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            color: Colors.white,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppStartingPoint();
        }
        return Container(
          color: Colors.white,
        );
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
            create: (context)=>HomePageVM()),
        ChangeNotifierProvider<CompanyDetailsPageVM>(
            create: (context)=>CompanyDetailsPageVM()),
        ChangeNotifierProvider<AdminPanelVM>(
            create: (context)=>AdminPanelVM()),
        ChangeNotifierProvider<CartPageVM>(
            create: (context)=>CartPageVM()),
        ChangeNotifierProvider<NotificationsVM>(
            create: (context)=>NotificationsVM())

      ],
      child: GetMaterialApp(
        //locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
        //builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
        title: 'Localy',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme()
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          backgroundColor: Colors.white,
          name: 'assets/animations/splash.flr',
          next: RegistrationPage(),
          until: () => Future.delayed(Duration(seconds: 4)),
          startAnimation: 'intro',
          transitionDuration: Duration(seconds: 2),
          transition: Transition.fadeIn,
        ),
      ),
    );
  }


}

