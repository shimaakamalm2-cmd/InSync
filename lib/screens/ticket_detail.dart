import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class TicketDetailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => TicketDetailPageState();
}

class TicketDetailPageState extends State<TicketDetailPage> {

  double radius = 0;
  RadialGradient backgroundRadialGradient = RadialGradient(colors: [Colors.transparent, Colors.transparent]);
  double opacity = 0;

  // Ticket? ticket;
  //
  // TicketDetailPage({super.key, required this.ticket});

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 1), () {
      opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    computeDisplayBorderRadius();
    // TODO: implement build
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(children: [
        AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: 1200),
          child: Container(
            decoration: BoxDecoration(borderRadius: .all(.circular(radius)), gradient: RadialGradient(colors: [InSyncColors.mediumPriority, Theme.of(context).scaffoldBackgroundColor], center: .topLeft, radius: MediaQuery.heightOf(context) * 0.0009)),
            clipBehavior: .hardEdge,
          ),
        ),
        Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,

          appBar:
          PreferredSize(
            preferredSize: .fromHeight(70),
            child: Container(
              padding: .directional(start: 15, end: 15),
              child: AppBar(
                automaticallyImplyLeading: NativeLiquidGlassUtils.supportsLiquidGlass ? false : true,
                centerTitle: false,
                toolbarHeight: 65,
                title: Text(
                  'Ticket',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                backgroundColor: Colors.transparent,
                leading: NativeLiquidGlassUtils.supportsLiquidGlass ? LiquidGlassButton.icon(onPressed: () { Navigator.pop(context); }, icon: NativeLiquidGlassIcon.sfSymbol("chevron.left")) : IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios_new),),

                actions: [
                  NativeLiquidGlassUtils.supportsLiquidGlass ?
                  LiquidGlassButton.icon(onPressed: (){}, icon: NativeLiquidGlassIcon.sfSymbol("ellipsis")) :
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.ellipsis),
                  ),
                ],

                leadingWidth: 45,
                titleSpacing: 25,
              ),
            ),
          ),

          body: Container(
            padding: .symmetric(horizontal: 15),
            decoration: BoxDecoration(borderRadius: .vertical(top: .circular(80))),
            child: ListView(
              children: [
                Column(
                  spacing: 20,
                  children: [
                    InSyncList(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      items: [
                        InSyncListItem(
                          boldTitle: true,
                          spacing: 10,
                          title: "InSync",
                          subtext: "The ultimate project manager",
                          leadingAccessory: Container(
                              padding: .all(2),
                              child: Image.asset("assets/images/logo.png", width: 46, height: 46)),
                          trailingAccessory: ExclusionFilter(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: InSyncColors.prominentItemColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ]
                    ),
                    InSyncList(
                      padding: .all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      items: [
                        InSyncListItem(
                          boldTitle: true,
                          title: "Due Date",
                          trailingAccessory: Text("Thu 8 Nov, 2026", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                        InSyncListItem(
                            boldTitle: true,
                            title: "Assigned by",
                            trailingAccessory: Text("Your dog", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                        InSyncListItem(
                            boldTitle: true,
                            title: "Assigned to",
                            trailingAccessory: Text("+46173", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                      ]
                    ),
                    InSyncList(
                        title: "Description",
                        padding: .all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        items: [
                          InSyncListItem(
                              spacing: 0,
                              bottomAccessory: Text(
                                "hiiiii this is a flutter app how aree youuu are you okay ....",
                                softWrap: true,
                              ),
                          ),
                        ]
                    ),
                    InSyncList(
                        padding: .all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        items: [
                          InSyncListItem(
                              boldTitle: true,
                              title: "Description",
                              trailingAccessory: Text("Thu 8 Nov, 2026", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                          ),
                        ]
                    ),
                  ],
                )
              ],
            ),
          ),
          ),
      ],
      )
    );
  }

  void computeDisplayBorderRadius() {

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Future<IosDeviceInfo> deviceInfo = deviceInfoPlugin.iosInfo;

    deviceInfo.then((onValue) {
      if (onValue.modelName.contains("iPhone SE")) {
        radius = 6;
      } else if ((onValue.modelName.contains("iPhone 17") || onValue.modelName.contains("iPhone 18") || onValue.modelName.contains("iPhone 16")) && !onValue.modelName.contains("e", 7)) {
        radius = 65;
      } else if (onValue.modelName.contains("iPhone")) {
        radius = 56;
      }

      setState(() {});
    });
  }
}
