import 'package:flutter/material.dart';

Future showAdaptiveModalSheet(BuildContext context, Widget Function(BuildContext context) builder) async {
  return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      clipBehavior: .none,
      backgroundColor: Colors.transparent,
      sheetAnimationStyle: .new(curve: Curves.fastEaseInToSlowEaseOut,
      duration: Duration(milliseconds: 500),
      reverseCurve: Curves.fastEaseInToSlowEaseOut,
      reverseDuration: Duration(milliseconds: 300)),
      context: context,
      builder: builder,
  );
}