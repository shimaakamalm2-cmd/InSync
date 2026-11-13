import 'package:cupertino_native_better/components/native_tab_bar.dart';
import 'package:cupertino_native_better/components/tab_bar.dart';
import 'package:cupertino_native_better/cupertino_native.dart';
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

    // return CNTabBar(items: [
    //   CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
    //   CNTabBarItem(label: 'Ticket', icon: CNSymbol('ticket.fill')),
    //   CNTabBarItem(label: 'Search', icon: CNSymbol('magnifyingglass')),
    //   CNTabBarItem(icon: CNSymbol('plus'), menuItems: [
    //     CNPopupMenuItem(label: 'New Checklist', icon: CNSymbol('checklist')),
    //   ]),
    // ], currentIndex: 0, onTap: (onTap){
    //
    // },
    //   splitSpacing: 0,
    //   iconSize: 18,
    //   shrinkCentered: false,
    //   split: true,
    // );

    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? LiquidGlassTabBar(
      items: const [
        LiquidGlassTabItem(
          label: 'Home',
          icon: NativeLiquidGlassIcon.sfSymbol('house'),
        ),
        LiquidGlassTabItem(
          label: 'Ticket',
          icon: NativeLiquidGlassIcon.sfSymbol('ticket'),
        ),
        LiquidGlassTabItem(
          label: 'Search',
          icon: NativeLiquidGlassIcon.sfSymbol('magnifyingglass'),
        ),
      ],
      currentIndex: selectedIndex,
      onTabSelected: (int index) {

        onTabChange(index);
      },
      iosActionButton: .new(
        label: 'New',
        icon: NativeLiquidGlassIcon.sfSymbol('plus'),
        iconSize: 19,
        selectedItemColor:
        Theme.of(context).colorScheme.primary,
      ),
      selectedItemColor:
      Theme.of(context).colorScheme.primary,
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
          label: 'Search',
        ),
      ],
    );
  }
}