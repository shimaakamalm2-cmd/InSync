import 'package:flutter/material.dart';

//GENERATED 
// used as fallback if liquidglassbar is not supported (if not ios 27+)
class PlaceholderNavBar extends StatelessWidget {
  const PlaceholderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
          label: 'My Ticket',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
      ],
    );
  }
}