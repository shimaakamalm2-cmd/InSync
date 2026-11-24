import 'package:cupertino_native_better/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:insync/screens/my_ticket_screen.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/auth-screens/onboarding_screen.dart';

const _defaultDebugPropertiesValue = true;

class InSyncAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool debugProperties;

  const InSyncAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.debugProperties = _defaultDebugPropertiesValue,
  });

  @override
  State<StatefulWidget> createState() => InSyncAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class InSyncAppBarState extends State<InSyncAppBar> {

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int selectedTabIndex = -1;

  @override
  void initState() {
    super.initState();
    prefs.then((onValue) {
      setState(() {
        selectedTabIndex = onValue.getInt("tab_index") ?? -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      centerTitle: false,
      // backgroundColor: Colors.transparent,
      toolbarHeight: 65,
      automaticallyImplyLeading: widget.showBackButton,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        NativeLiquidGlassUtils.supportsLiquidGlass
            ? LiquidGlassButton.icon(
                onPressed: () {},
                icon: NativeLiquidGlassIcon.sfSymbol('gear'),
              )
            : IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.settings_solid),
              ),
        SizedBox.fromSize(
          size: const Size(6, 1),
        ),

        // DEBUG

        if (widget.debugProperties)

        NativeLiquidGlassUtils.supportsLiquidGlass ?
         CNPopupMenuButton.icon(items: [
           const CNPopupMenuItem(
             label: 'Show sample ticket',
             icon: CNSymbol('ticket', size: 16),
           ),
           const CNPopupMenuItem(
             label: 'Show onboarding',
             subtitle: "Replaces the current navigation stack with the onboarding sequence",
             icon: CNSymbol('door.left.hand.open', size: 16),
           ),
           CNPopupMenuDivider(),
           CNPopupMenuSubmenu(label: 'Default tab bar index', items: [
              CNPopupMenuItem(
               label: 'Home',
               checked: selectedTabIndex == 0,
             ),
             CNPopupMenuItem(
               label: 'My Tickets',
               checked: selectedTabIndex == 1,
             ),
             CNPopupMenuItem(
               label: 'Search',
               checked: selectedTabIndex == 2,
             ),
           ])
         ],  buttonIcon: CNSymbol('ladybug', size: 18), onSelected: (path) {

         }, onPathSelected: (path) {
           switch (path.first) {
             case 2 :
               switch (path.last) {
                 case 0:
                   setState(() {
                     selectedTabIndex = 0;
                   });
                   break;
                 case 1:
                   setState(() {
                     selectedTabIndex = 1;
                   });
                   break;
                 case 2:
                 setState(() {
                   selectedTabIndex = 2;
                 });
                 break;
               }
             case 1:
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => OnboardingScreen()), (_) => false);
               break;
             case 0:
               // TODO: Resolve Navigator issue
               // Navigator.pushNamed(
               //   context,
               //   "ticket_detail"
               // );
               Navigator.push(
                   context,
                   MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: getSampleTickets()[0])));
               break;
           }
         })
        :
        PopupMenuButton(
          itemBuilder: (itemBuilder) {
            return [
              PopupMenuItem(
                child: const Text('Sample Ticket'),
                onTap: () {
                  // TODO: Resolve Navigator issue
                  // Navigator.pushNamed(
                  //   context,
                  //   "ticket_detail",
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: getSampleTickets()[0]))
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Show Onboarding'),
                onTap: () {

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => OnboardingScreen()), (_) => false);
                },
              ),
            ];
          },
        ),
      ],
      actionsPadding:
          const EdgeInsetsDirectional.only(end: 15),
      titleSpacing: 25,
    );
  }
}
