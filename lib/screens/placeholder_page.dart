import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Can be used as is or can be subclassed.
class PlaceholderPage extends StatelessWidget {

  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        spacing: 20,
        mainAxisAlignment: .center,
        children: [
          Center(
            child: Icon(CupertinoIcons.hammer_fill, size: 100, color: Colors.grey.withAlpha(150),),
          ),
          Text("Page is under construction", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.withAlpha(150)))
        ],
      ),
    );
  }
}