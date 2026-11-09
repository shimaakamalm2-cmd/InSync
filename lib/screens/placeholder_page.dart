import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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