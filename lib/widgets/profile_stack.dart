import 'package:flutter/material.dart';
import 'package:insync/widget_lib/notched_circle.dart';

// Artificially limited to 4 profiles, adding more to the array will display a counter bubble at the end of the stack instead

class ProfileStack extends StatelessWidget {

  final List<Widget> children;

  const ProfileStack({super.key, required this.children});

  @override
  Widget build(BuildContext context) {

    int mapCounter = -1;

    return Container(
      height: 30,
      width: 120,
      // color: Colors.green,
      child:
      // ListView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: .horizontal,
      //     itemExtent: 25,
      //     // separatorBuilder: (_, _) => const SizedBox(width: 0),
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: stack.length > 4 ? 5 : stack.length,
      //     itemBuilder: (itemBuilder, itemCount) {
      //       if (itemCount == 0) {
      //         return ClipOval(
      //           clipBehavior: .hardEdge,
      //           child: stack[itemCount],
      //         );
      //       } else if (itemCount == 4) {
      //         return ClipPath(
      //           clipper: ClipNotchedCircle(),
      //           clipBehavior: .hardEdge,
      //           child: Container(
      //             color: Theme.of(context).colorScheme.tertiaryContainer,
      //             child: Center(
      //               child: Text("${stack.length - 4}", style: .new(fontSize: 4),),
      //             ),
      //           ),
      //         );
      //       } else {
      //         return ClipPath(
      //           clipper: ClipNotchedCircle(),
      //           clipBehavior: .hardEdge,
      //           child: stack[itemCount],
      //         );
      //       }
      //     }
      // ),
      Stack(
        clipBehavior: .none,
        children: [
          ...children.sublist(0, 5).map((toElement) {
            mapCounter++;

            if (mapCounter == 0) {
              return ConstrainedBox(
                constraints: .expand(width: 30, height: 30),
                child: ClipOval(
                  clipBehavior: .hardEdge,
                  child: children[mapCounter],
                ),
              );
            } else if (mapCounter == 4) {
              return Positioned.directional(
                textDirection: .ltr,
                start: 22.0 * mapCounter.toDouble(),
                child: ConstrainedBox(
                  constraints: .expand(width: 30, height: 30),
                  child: ClipPath(
                    clipper: ClipNotchedCircle(),
                    clipBehavior: .hardEdge,
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: FittedBox(
                        child: Padding(
                          padding: .directional(start: 15, end: 5),
                          child: Row(
                            crossAxisAlignment: .center,
                            mainAxisAlignment: .end,
                            children: [
                              Text("+${children.length - 4}", style: .new(fontWeight: .bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Positioned.directional(
                textDirection: .ltr,
                start: 22.0 * mapCounter.toDouble(),
                child: ConstrainedBox(
                  constraints: .expand(width: 30, height: 30),
                  child: ClipPath(
                    clipper: ClipNotchedCircle(),
                    clipBehavior: .hardEdge,
                    child: children[mapCounter],
                  ),
                ),
              );
            }
          })
        ],
      )
    );
  }
}