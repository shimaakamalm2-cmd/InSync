import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';

class CalendarCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        _CalendarCarouselPiece(),
      ],
    );
  }
}

class _CalendarCarouselPiece extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 67.8,
      height: 84.97,
      decoration: BoxDecoration(borderRadius: .all(.circular(20)), color: Theme.of(context).colorScheme.secondaryContainer),
      padding: .directional(top: 13, bottom: 13),
      child: Column(
        mainAxisAlignment: .spaceAround,
        children: [
          Text("30"),
          Text("Mon")
        ]
      )
    );
  }
}