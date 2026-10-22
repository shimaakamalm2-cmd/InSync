import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const Tag({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          // side: BorderSide(
          //   width: 1,
          //   color: const Color(0x3F525252),
          // ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: backgroundColor == Theme.of(context).colorScheme.tertiaryContainer ? null : textColor.withAlpha(217),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}