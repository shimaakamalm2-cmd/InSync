import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ContributionCard extends StatefulWidget {

  int dayOfWeek;
  int closedTickets;

  ContributionCard({super.key, required this.dayOfWeek, required this.closedTickets});

  @override
  State<StatefulWidget> createState() => ContributionCardState();
}

class ContributionCardState extends State<ContributionCard> {

  @override
  Widget build(BuildContext context) {

    return Container( //its trying to make it SizedBox for some reason
      height: 195,
      width: double.infinity,
      child: Card(
        clipBehavior: .hardEdge,
        shadowColor: Colors.transparent,
        color: InSyncColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: .start,
          children: [
            Expanded(
                child:
                Container(
                    padding: .directional(start: 22, top: 15),
                    child:
                    RichText(text: TextSpan(
                        text: "Closed ",
                        style: .new(fontSize: 31,
                            fontWeight: .bold, color: InSyncColors.quaternary, fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily.toString()),
                        children: [
                          TextSpan(
                            text: "${widget.closedTickets}",
                            style: .new(fontSize: 32,
                                fontWeight: .bold, color: Theme.of(context).colorScheme.onSurface),
                          ),
                          TextSpan(
                            text: " Tickets in the last",
                            style: .new(fontSize: 31,
                                fontWeight: .bold, color: InSyncColors.quaternary),
                          ),
                        ]
                    ))
                )
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child:
                      Stack(
                        alignment: .bottomCenter,
                        children: [
                          Positioned.directional(
                              textDirection: .ltr,
                              top: 55,
                              end: 22,
                              child:
                              Container(
                                transformAlignment: .directional(0, -80),
                                width: 147,
                                height: 147,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(31),
                                ),
                                child: Container(
                                  padding: .directional(top: 7),
                                  child: Stack(
                                    alignment: .topCenter,
                                    children: [
                                      ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) {
                                          var gradient = LinearGradient(
                                              transform: GradientRotation(-90),
                                              colors: [
                                                Color.fromARGB(255, 247, 209, 165),
                                                Color.fromARGB(255, 244, 181, 108)
                                              ]);
                                          return gradient.createShader(.fromPoints(bounds.centerLeft, bounds.centerRight));
                                        },
                                        child:
                                        Text("Days", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: .bold, fontFamily: "SF-Pro-Rounded")),
                                      ),
                                      Positioned.directional(
                                          textDirection: .ltr,
                                          top: -10,
                                          child:
                                          ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                var gradient = LinearGradient(
                                                    transform: GradientRotation(-90),
                                                    colors: [
                                                      Color.fromARGB(255, 244, 181, 108),
                                                      Color.fromARGB(255, 247, 209, 165)
                                                    ]);
                                                return gradient.createShader(.fromPoints(bounds.centerLeft, bounds.centerRight));
                                              },
                                              child:
                                              Text("${widget.dayOfWeek}", style: TextStyle(fontSize: 156, color: Colors.black, fontWeight: .bold, fontFamily: "SF-Pro-Rounded")))
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ),
                          Positioned.directional(
                              textDirection: .ltr,
                              top: 37,
                              end: 47,
                              child:
                              Row(
                                spacing: 62,
                                children: [
                                  Container(
                                    transformAlignment: .directional(0, -80),
                                    width: 17,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                  ),
                                  Container(
                                    transformAlignment: .directional(0, -80),
                                    width: 17,
                                    height: 39,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}