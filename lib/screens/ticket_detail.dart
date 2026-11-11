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
            AppBar(
              toolbarOpacity: 1,
              automaticallyImplyLeading: NativeLiquidGlassUtils.supportsLiquidGlass ? false : true,
              animateColor: true,
              centerTitle: false,
              toolbarHeight: 65,
              title: Text(
                'Ticket',
                style: TextStyle(
                  color: InSyncColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              backgroundColor: Colors.transparent,
              leading: Container(
                padding: .directional(start: 15),
                child: NativeLiquidGlassUtils.supportsLiquidGlass ? LiquidGlassButton.icon(onPressed: () { Navigator.of(context).pop(); }, icon: NativeLiquidGlassIcon.sfSymbol("chevron.left")) : IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios_new),),
              ),

              actions: [
                Container(
                padding: .directional(end: 15),
                child:
                  NativeLiquidGlassUtils.supportsLiquidGlass ?
                  LiquidGlassButton.icon(onPressed: (){}, icon: NativeLiquidGlassIcon.sfSymbol("ellipsis")) :
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.ellipsis),
                    ),
                  ),
              ],

              leadingWidth: 0,
              titleSpacing: 72,
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
                          trailingAccessory: Container(
                              padding: .all(2),
                              child: Image.asset("assets/images/logo.png", width: 46, height: 46)),
                          leadingAccessory: ExclusionFilter(
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
                          leadingAccessory: Text("Thu 8 Nov, 2026", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                        InSyncListItem(
                            boldTitle: true,
                            title: "Assigned by",
                            leadingAccessory: Text("Your dog", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                        InSyncListItem(
                            boldTitle: true,
                            title: "Assigned to",
                            leadingAccessory: Text("+46173", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
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
                              boldTitle: true,
                              title: "Last Modified"
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
                              title: "Last Modified",
                              leadingAccessory: Text("Thu 8 Nov, 2026", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
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