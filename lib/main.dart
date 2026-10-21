import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily, colorScheme: .fromSeed(seedColor: Colors.blue)),

      home: Scaffold(
        backgroundColor: Colors.white, 
        appBar: AppBar(title: Text("InSync"), centerTitle: false,),
        body: SingleChildScrollView(
          child: Container(
            padding: .all(15),
            child: Column(
              spacing: 20,
              children: [
                PriorityTicketsCard(),
                ProjectList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}