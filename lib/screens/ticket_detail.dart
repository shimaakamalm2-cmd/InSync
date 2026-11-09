import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../model/ticket.dart';

class TicketDetailPage extends StatelessWidget {

  Ticket? ticket;

  TicketDetailPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(borderRadius: .all(.circular(65)), gradient: RadialGradient(colors: [InSyncColors.red, Theme.of(context).scaffoldBackgroundColor], center: .topLeft, radius: 0.8)),
      clipBehavior: .hardEdge,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: .fromHeight(80),
          child: Container(
            padding: .directional(start: 15, end: 15),
            child: AppBar(
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
              leading: LiquidGlassButton.icon(onPressed: (){
                Navigator.pop(context);
              }, icon: NativeLiquidGlassIcon.sfSymbol("chevron.left")),

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

}