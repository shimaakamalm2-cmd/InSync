import 'package:cupertino_native_better/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:insync/screens/my_ticket_screen.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/common/modal.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/auth-screens/onboarding_screen.dart';
import '../../screens/invite_sheet.dart';

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
      backgroundColor: Colors.transparent,
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
            ? GlassButton(
          SFSymbolName: "person.fill.badge.plus",
          onPressed: () {
            showAdaptiveModalSheet(context, (_) {
              return Container(
                decoration:
                BoxDecoration(
                    borderRadius: .all(.circular(35))
                ),
                clipBehavior: .hardEdge,
                child: InvitePage(),
              );
            });
          },
        )
            : IconButton(
                onPressed: () {
                  showAdaptiveModalSheet(context, (_) {
                    return Container(
                      decoration:
                      BoxDecoration(
                          borderRadius: .all(.circular(35))
                      ),
                      clipBehavior: .hardEdge,
                      child: InvitePage(),
                    );
                  });
                },
                icon: const Icon(CupertinoIcons.settings_solid),
              ),
        SizedBox.fromSize(
          size: const Size(6, 1),
        ),

        // DEBUG

        if (widget.debugProperties)

        NativeLiquidGlassUtils.supportsLiquidGlass ?
         CNPopupMenuButton.icon(items: [
           CNPopupMenuDivider(),
           CNPopupMenuSubmenu(label: "Pages", items: [
             const CNPopupMenuItem(
               label: 'Example ticket',
               icon: CNSymbol('ticket', size: 16),
             ),
             const CNPopupMenuItem(
               label: 'Show onboarding',
               subtitle: "Replaces the current navigation stack with the onboarding sequence",
               icon: CNSymbol('door.left.hand.open', size: 16),
             ),
           ]),
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

         }, onPathSelected: (path) async {
           switch (path.first) {
             case 2:
               setState(() {
                 selectedTabIndex = path.last;
               });
               prefs.then((onValue) {
                 onValue.setInt("tab_index", path.last);
               });
             case 1:
               switch (path.last) {
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
                 case 1:
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => OnboardingScreen()), (_) => false);
                   break;
               }
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
              PopupMenuItem(
                child: const Text('Invite'),
                onTap: () {

                  showAdaptiveModalSheet(context, (_) => DraggableScrollableSheet(builder: (_, _) => InvitePage()));
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
