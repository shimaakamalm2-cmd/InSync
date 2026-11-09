import 'package:flutter/material.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

//GENERATED 
// used as fallback if liquidglassbar is not supported (if not ios 27+)
// update: now automatically adjusts between tab bars according to the OS and version
class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
      currentIndex: 0,
      onTabSelected: (_) {},
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
      selectedIndex: 0, // Highlights the first item as default
      onDestinationSelected: (int index) {
        // Placeholder action when an item is tapped
        print('Selected tab: $index');
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