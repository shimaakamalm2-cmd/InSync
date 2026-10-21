import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insync/widgets/priority_tickets.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),

      home: Scaffold(
        backgroundColor: Colors.white, 
        appBar: AppBar(title: Text("Hello"),),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: const PriorityTicketsCard(),
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: const PriorityTicketsCard(),
            ),
          ],
        ),
        ),
    );
  }
}