import 'package:flutter/material.dart';
import 'package:insync/widgets/priority_tickets.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, 
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const PriorityTicketsCard(),
          ),
        ),
      ),
    );
  }
}