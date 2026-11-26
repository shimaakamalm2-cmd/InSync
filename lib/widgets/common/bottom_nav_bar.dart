import 'package:cupertino_native_better/components/popup_menu_button.dart';
import 'package:cupertino_native_better/components/tab_bar.dart';
import 'package:cupertino_native_better/style/sf_symbol.dart';
import 'package:flutter/material.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

//GENERATED 
// used as fallback if liquidglassbar is not supported (if not ios 27+)
// update: now automatically adjusts between tab bars according to the OS and version
class AppNavBar extends StatelessWidget {
  int selectedIndex;
  Function(int index) onTabChange;

  AppNavBar({super.key, this.selectedIndex = 0, required this.onTabChange});

  @override
  Widget build(BuildContext context) {

    // LiquidGlassTabBar(
    //   items: const [
    //     LiquidGlassTabItem(
    //       label: 'Home',
    //       icon: NativeLiquidGlassIcon.sfSymbol('house'),
    //     ),
    //     LiquidGlassTabItem(
    //       label: 'Ticket',
    //       icon: NativeLiquidGlassIcon.sfSymbol('ticket'),
    //     ),
    //     LiquidGlassTabItem(
    //       label: 'Projects',
    //       icon: NativeLiquidGlassIcon.sfSymbol('app.shadow'),
    //     ),
    //   ],
    //   currentIndex: selectedIndex,
    //   onTabSelected: (int index) {
    //
    //     onTabChange(index);
    //   },
    //   iosActionButton: .new(
    //     label: 'New',
    //     icon: NativeLiquidGlassIcon.sfSymbol('plus'),
    //     iconSize: 19,
    //     selectedItemColor:
    //     Theme.of(context).colorScheme.primary,
    //   ),
    //   selectedItemColor:
    //   Theme.of(context).colorScheme.primary,
    // );

    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? CNTabBar(
      items: [
        CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
        CNTabBarItem(label: 'Ticket', icon: CNSymbol('airplane.ticket.fill')),
        CNTabBarItem(label: 'Projects', icon: CNSymbol('app.shadow')),
        CNTabBarItem(icon: CNSymbol('plus'), menuItems: [
          CNPopupMenuItem(label: 'New Ticket', icon: CNSymbol('checklist')),
        ]
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        onTabChange(index);
      },
      autoHideOnPageTransition: false,
      autoHideOnModal: false,
      splitSpacing: 25,
      iconSize: 18,
      split: true,
    )
        :
    NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {

        onTabChange(index);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.airplane_ticket_rounded),
          label: 'My Tickets',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_rounded),
          label: 'Projects',
        ),
      ],
    );
  }
}