import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily, colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const HomeScreen(),
    );
  }
}