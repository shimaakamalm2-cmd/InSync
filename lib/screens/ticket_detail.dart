import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class TicketDetailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => TicketDetailPageState();
}

class TicketDetailPageState extends State<TicketDetailPage> {

  double radius = 0;

  // Ticket? ticket;
  //
  // TicketDetailPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    computeDisplayBorderRadius();
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(borderRadius: .all(.circular(radius)), gradient: RadialGradient(colors: [InSyncColors.mediumPriority, Theme.of(context).scaffoldBackgroundColor], center: .topLeft, radius: MediaQuery.heightOf(context) * 0.0009)),
      clipBehavior: .hardEdge,
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: PreferredSize(
          preferredSize: .fromHeight(80),
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

        body: Column(
          children: [
          ],
        ),
      ),
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