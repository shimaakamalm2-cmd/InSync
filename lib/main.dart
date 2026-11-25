import 'package:cupertino_native_better/components/tab_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inspire_blur/inspire_blur.dart';
import 'package:insync/colors.dart';
import 'package:insync/firebase_options.dart';
import 'package:insync/screens/auth-screens/onboarding_screen.dart';
import 'package:insync/screens/start_page.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

void main() async {

  // prepares the progressive blur effect present in the onboarding page
  // TODO: make this process skip
  Inspire.warmUp();

  // preparing Flutter before running async setup
  WidgetsFlutterBinding.ensureInitialized();
  // connecting the app to Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme(
          brightness: .light,
          primary: InSyncColors.primary,
          onPrimary: InSyncColors.quaternary,
          secondary: InSyncColors.secondary,
          onSecondary: InSyncColors.white,
          error: InSyncColors.red,
          onError: InSyncColors.red.withAlpha(128),
          surface: InSyncColors.primaryBackground.light,
          onSurface: InSyncColors.primaryText.light,
          secondaryContainer: InSyncColors.secondaryBackground.light,
          onSurfaceVariant: InSyncColors.secondaryText.light,
          tertiaryContainer: InSyncColors.tertiaryBackground.light,
          onTertiary: InSyncColors.black,
        ),

        navigationBarTheme: .new(
          // height: 70,
          iconTheme: .resolveWith((callback) {
            if (callback.isNotEmpty && callback.single == .selected) {
              return IconThemeData(color: InSyncColors.primary);
            } else {
              return .new(color: InSyncColors.black);
            }
          }),
          // indicatorColor: Colors.transparent,
          labelTextStyle: .resolveWith((callback) {
            if (callback.isNotEmpty && callback.single == .selected) {
              return TextStyle(color: InSyncColors.primary, fontWeight: .bold);
            } else {
              return .new(color: InSyncColors.black);
            }
          }),
        ),
      ),


      darkTheme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme(
          brightness: .dark,
          primary: InSyncColors.primary,
          onPrimary: InSyncColors.quaternary,
          secondary: InSyncColors.secondary,
          onSecondary: InSyncColors.white,
          error: InSyncColors.red,
          onError: InSyncColors.red.withAlpha(128),
          surface: InSyncColors.primaryBackground.dark,
          onSurface: InSyncColors.primaryText.dark,
          secondaryContainer: InSyncColors.secondaryBackground.dark,
          onSurfaceVariant: InSyncColors.secondaryText.dark,
          tertiaryContainer: InSyncColors.tertiaryBackground.dark,
        ),

        navigationBarTheme: .new(
          backgroundColor: InSyncColors.black.withAlpha(235),
          shadowColor: Colors.transparent,
          // height: 70,
          iconTheme: .resolveWith((callback) {
            if (callback.isNotEmpty && callback.single == .selected) {
              return IconThemeData(color: InSyncColors.primary);
            } else {
              return .new(color: InSyncColors.white);
            }
          }),
          // indicatorColor: Colors.transparent,
          labelTextStyle: .resolveWith((callback) {
            if (callback.isNotEmpty && callback.single == .selected) {
              return TextStyle(color: InSyncColors.primary, fontWeight: .bold);
            } else {
              return .new(color: InSyncColors.white);
            }
          }),
        ),
      ),

      navigatorObservers: [LiquidGlassNavigatorObserver(), CNTabBarRouteObserver()],
      home: StartPage(),
    );
  }
}