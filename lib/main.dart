import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:speakup_bridge/views/screens/screen_login.dart';
import 'package:speakup_bridge/views/screens/screen_user_home_page.dart';
import 'package:speakup_bridge/widgtes/custom_error.dart';

import 'constants/colors/colors.dart';
import 'constants/style/style.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 2));
  colorConfig();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

void colorConfig() {
  appPrimaryColor = MaterialColor(
    0xFF002A8D,
    const <int, Color>{
      50: const Color(0xFF002A8D),
      100: const Color(0xFF002A8D),
      200: const Color(0xFF002A8D),
      300: const Color(0xFF002A8D),
      400: const Color(0xFF002A8D),
      500: const Color(0xFF002A8D),
      600: const Color(0xFF002A8D),
      700: const Color(0xFF002A8D),
      800: const Color(0xFF002A8D),
      900: const Color(0xFF002A8D),
    },
  );
  appBoxShadow = [BoxShadow(blurRadius: 18, color: Color(0x414D5678))];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            home: FirebaseAuth.instance.currentUser == null
                ? ScreenLogin()
                : ScreenUserHomePage(),
            locale: Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fade,
            title: "Speakup Bridge",
            theme: ThemeData(
              fontFamily: 'Poppins',
              radioTheme: RadioThemeData(),
              checkboxTheme: CheckboxThemeData(
                checkColor: MaterialStateProperty.all(Colors.white),
                fillColor: MaterialStateProperty.all(appPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: BorderSide(color: Color(0xff585858), width: 1),
              ),
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
                centerTitle: false,
                systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: appPrimaryColor),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              dividerColor: Colors.transparent,
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: appPrimaryColor)
                  .copyWith(background: Color(0xFFFAFBFF)),
            ),
            builder: (context, widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return ScrollConfiguration(
                  behavior: NoColorScrollBehavior(), child: widget!);
            },
          );
        });
  }
}

class NoColorScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
