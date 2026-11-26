import 'package:native_liquid_glass/src/liquid_glass_container.dart';
import 'package:flutter/material.dart';
import 'package:insync/screens/placeholder_page.dart';

class InviteHistory extends PlaceholderPage {

  const InviteHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: .tight(.fromHeight(430)),
      child: Container(
        decoration: BoxDecoration(borderRadius: .all(.circular(35))),
        clipBehavior: .hardEdge,
        child: Scaffold(
          backgroundColor: MediaQuery.of(context).platformBrightness == .dark ? Theme.of(context).colorScheme.secondaryContainer
              .withValues(alpha: 1, red: 0.09, green: 0.09, blue: 0.09) : Theme.of(context).colorScheme.secondaryContainer
              .withValues(alpha: 1, red: 0.86, green: 0.86, blue: 0.86) ,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            // Stops that weird primary color bleeding when scrolling.
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 75,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: .only(bottom: 2),
              // Keeps the Flutter title in its own composited layer
              // to avoid hiding when a native UIKit/SwiftUI view
              // is rendered in view
              child: LiquidGlassContainer(
                config: .new(
                  effect: .regular,
                  shape: .custom,
                  backgroundColor: Colors.transparent,
                  customPath: [.close()],
                  customPathSize: Size(10, 10),
                ),
                child: Text(
                  "History",
                  style: .new(fontWeight: .bold, fontSize: 23),
                ),
              ),
            ),
            actions: [],
            actionsPadding: const EdgeInsetsDirectional.only(end: 15),
            titleSpacing: 25,
          ),
          body: super.build(context)
        ),
      ),
    );
  }
}