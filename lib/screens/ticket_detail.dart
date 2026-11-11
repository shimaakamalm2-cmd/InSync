import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/model/ticket.dart';
import 'package:insync/widgets/bottom_nav_bar.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket ticket;
  const TicketDetailPage({
    super.key,
    required this.ticket,
  });

  @override
  State<StatefulWidget> createState() => TicketDetailPageState();

}

class TicketDetailPageState extends State<TicketDetailPage> {

  final DraggableScrollableController _drawerController = DraggableScrollableController();
  bool _drawerVisible = true;

  double radius = 0;
  RadialGradient backgroundRadialGradient = RadialGradient(colors: [Colors.transparent, Colors.transparent]);
  double opacity = 0;

  // Ticket? ticket;
  //
  // TicketDetailPage({super.key, required this.ticket});

  @override
  void initState() {
    super.initState();
    _drawerController.addListener(_handleDrawerExtentChange);
    Future.delayed(Duration(microseconds: 1), () {
      opacity = 1;
    });
  }

  void _handleDrawerExtentChange() {
    if (_drawerController.isAttached && _drawerController.size <= 0.081 && _drawerVisible) {
      setState(() => _drawerVisible = false);
    }
  }

  @override
  void dispose() {
    _drawerController.removeListener(_handleDrawerExtentChange);
    _drawerController.dispose();
    super.dispose();
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
                          title: widget.ticket.title,
                          subtext: widget.ticket.description,
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
                          trailingAccessory: Text(widget.ticket.dueDate.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                        ),
                        InSyncListItem(
                            boldTitle: true,
                            title: "Assigned by",
                            trailingAccessory: Text(widget.ticket.assignedBy.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
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
                                widget.ticket.description,
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
                              title: "Last Modified",
                              trailingAccessory: Text(widget.ticket.lastUpdated.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: .w600, fontSize: 13))
                          ),
                        ]
                    ),
                  ],
                )
              ],
            ),
          ),
          bottomSheet: _drawerVisible ? DraggableScrollableSheet(
            controller: _drawerController,
            expand: false,
            initialChildSize: 0.25,
            minChildSize: 0.08,
            maxChildSize: 0.42,
            snap: true,
            snapSizes: const [0.08, 0.25, 0.42],
            builder: (context, scrollController) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.55),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                    borderRadius: BorderRadius.circular(36),
                    backgroundBlendMode: BlendMode.luminosity,
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 18)],
                  ),
                  child: SafeArea(
                    top: false,
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                      children: [
                    Center(
                      child: Container(
                        width: 64,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: InSyncColors.mediumPriority,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: const Text('Mark Complete'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: const Text('Request extension'),
                        ),
                      ),
                    ],
                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) : Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 1,
              child: IconButton.filledTonal(
                tooltip: 'Show ticket actions',
                onPressed: () => setState(() => _drawerVisible = true),
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: AppNavBar(onTabChange: (_) {}),
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
