import 'package:flutter/material.dart';
import 'package:insync/utils.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

const double _calendarPiecePadding = 8;

// measured manually
const double _textBoxHeight = 23;

const double _calendarPieceHeight = 84.97;
const double _dividerSpacer = 6;
const double _carouselHeight = 120;
const double _calendarPieceTopPadding = (_carouselHeight - _dividerSpacer - _calendarPieceHeight - _textBoxHeight) * 0.5;

class CalendarCarousel extends StatefulWidget {

  final Function(int index, DateTime date)? onSelect;
  final Function(int index, DateTime date)? onDeselect;
  int selectedIndex;

  CalendarCarousel({super.key, this.onSelect, this.onDeselect, this.selectedIndex = 0});

  @override
  State<StatefulWidget> createState() => _CalendarCarouselState();
}

class _CalendarCarouselState extends State<CalendarCarousel> {

  final CarouselScrollPhysics _carouselScrollPhysics = CarouselScrollPhysics();

  @override
  Widget build(BuildContext context) {
    // carouselScrollPhysics.carriedMomentum(80);

    return Container(
      alignment: .topCenter,
      // color: Colors.green,
      constraints: .new(minHeight: 90, maxHeight: _carouselHeight),
      child: CustomScrollView(
        // physics: CarouselScrollPhysics(),
        anchor: 0.025,
        scrollDirection: .horizontal,
        scrollBehavior: .new(),
        slivers: [
          SliverList.builder(itemBuilder: (buildContext, index) {

            DateTime date = DateTime.now().add(Duration(days: index));
            Widget calPiece = Column(
              crossAxisAlignment: .start,
              children: [
                Container(
                    padding: .directional(start: _calendarPiecePadding, end: _calendarPiecePadding, top: _calendarPieceTopPadding),
                    child: _CalendarCarouselPiece(date: date, isSelected: index == widget.selectedIndex, onTap: () {
                      if (widget.selectedIndex == index) {
                        widget.selectedIndex = -1;
                        widget.onDeselect?.call(index, date);
                      } else {
                        widget.selectedIndex = index;
                        widget.onSelect?.call(index, date);
                      }

                      setState(() {});
                    },)
                ),
              ],
            );

            if (date.day == 1) {
              return Row(
                children: [
                  Column(
                    spacing: _dividerSpacer,
                    children: [
                      Expanded(
                        child: Container(
                          width: 5,
                          decoration: BoxDecoration(color: InSyncColors.red, borderRadius: .all(.circular(80))),
                        ),
                      ),
                      Text(date.month != 1 ? DateFormat(DateFormat.ABBR_MONTH).format(date) : date.year.toString(), style: TextStyle(fontWeight: .bold, fontSize: 16),)
                    ],
                  ),
                  calPiece
                ],
              );
            }

            return calPiece;
          })
        ],
      ),
    );
  }
}

class _CalendarCarouselPiece extends StatelessWidget {

  final DateTime _date;
  final bool isSelected;
  final Function() onTap;

  const _CalendarCarouselPiece({required this._date, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        onTap();
      },
      radius: 200,
      borderRadius: .all(.circular(20)),
      // splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      child: AnimatedContainer(
        width: 67.8,
        height: _calendarPieceHeight,
        decoration: BoxDecoration(borderRadius: .all(.circular(20)), color: isSelected? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.secondaryContainer),
        padding: .directional(top: 13, bottom: 13),
        duration: Duration(milliseconds: 150),
        child: Column(
          mainAxisAlignment: .spaceAround,
          children: [
            Text("${_date.day}", style: TextStyle(fontWeight: .w900, fontFamily: "SF Pro Rounded", fontSize: 24),),
            Text(getWeekDay(_date.weekday % 7), style: TextStyle(fontWeight: .w900, fontFamily: "SF Pro Rounded", fontSize: 14),),
          ]
        )
      ),
    );
  }
}