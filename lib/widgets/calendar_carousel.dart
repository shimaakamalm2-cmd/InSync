import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/utils.dart';

class CalendarCarousel extends StatelessWidget {

  CarouselScrollPhysics carouselScrollPhysics = CarouselScrollPhysics();

  @override
  Widget build(BuildContext context) {
    // carouselScrollPhysics.carriedMomentum(80);

    return Container(
      height: 80,
      child: CustomScrollView(
        // physics: CarouselScrollPhysics(),
        scrollDirection: .horizontal,
        slivers: [
          SliverList.builder(itemBuilder: (buildContext, number) {
            return Container(
                padding: .directional(start: 5, end: 5),
                child: _CalendarCarouselPiece(date: DateTime.now().add(Duration(days: number))));
          })
        ],
      ),
    );
  }
}

class _CalendarCarouselPiece extends StatelessWidget {

  DateTime date;

  _CalendarCarouselPiece({required this.date});

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
          Text("${date.day}", style: TextStyle(fontWeight: .w900, fontFamily: "SF Pro Rounded", fontSize: 24),),
          Text(getWeekDay(date.weekday % 7), style: TextStyle(fontWeight: .w900, fontFamily: "SF Pro Rounded", fontSize: 14),),
        ]
      )
    );
  }
}