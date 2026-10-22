import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily, colorScheme: ColorScheme(brightness: .light, primary: InSyncColors.primary, onPrimary: InSyncColors.quaternary, secondary: InSyncColors.secondary, onSecondary: InSyncColors.white, error: InSyncColors.red, onError: InSyncColors.red.withAlpha(128), surface: InSyncColors.primaryBackground.light, onSurface: InSyncColors.primaryText.light, secondaryContainer: InSyncColors.secondaryBackground.light),
          navigationBarTheme: .new(
            height: 70,
            iconTheme: .resolveWith((callback) {
              if (callback.isNotEmpty && callback.single == .selected ) {
                return IconThemeData(color: InSyncColors.primary);
              } else {
                return .new(color: InSyncColors.black);
              }
            }),
            indicatorColor: Colors.transparent,
            labelTextStyle: .resolveWith((callback) {
              if (callback.isNotEmpty && callback.single == .selected ) {
                return TextStyle(color: InSyncColors.primary, fontWeight: .bold);
              } else {
                return .new(color: InSyncColors.black);
              }
            }),
          )
      ),
      home: const HomeScreen(),
    );
  }
}