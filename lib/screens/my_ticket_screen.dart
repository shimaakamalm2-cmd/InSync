import "package:flutter/material.dart";
import "package:insync/widgets/InSync_list.dart";
import "package:insync/widgets/app_bar.dart";
import "package:insync/widgets/calendar_carousel.dart";
import 'package:native_liquid_glass/native_liquid_glass.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}
//TODO: add the check for sorting 
// implement sorting logic 
//implement different sections for different priority level
class _MyTicketScreenState extends State<MyTicketScreen> {
  String sortLabel = 'Alphabetically';

  Widget _buildFilterMenu(BuildContext context) {
    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? LiquidGlassContainer(
          animateChanges: true,
          config: LiquidGlassConfig(cornerRadius: 80, interactive: true),
          child: LiquidGlassMenu(
            height: 37,
            menuTitle: 'Sort',
              items: const [
                LiquidGlassMenuItem(id: 'priority', title: 'By priority'),
                LiquidGlassMenuItem(
                  id: 'alphabetical',
                  title: 'Alphabetically',
                ),
                LiquidGlassMenuItem(id: 'project', title: 'By project'),
              ],
              onItemSelected: (id) {
                setState(() {
                  switch (id) {
                    case 'priority':
                      sortLabel = 'By priority';
                      break;
                    case 'alphabetical':
                      sortLabel = 'Alphabetically';
                      break;
                    case 'project':
                      sortLabel = 'By project';
                      break;
                  }
                });
              },
              icon: NativeLiquidGlassIcon.sfSymbol('line.3.horizontal.decrease.circle'),
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
        )
        : PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                sortLabel = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Priority',
                child: Text('Priority'),
              ),
              const PopupMenuItem<String>(
                value: 'Alphabetical',
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<String>(
                value: 'Project',
                child: Text('Project'),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InSyncAppBar(
        title: 'My Tickets',
        showBackButton: true,
      ),
      body: ListView(
        
        padding: const EdgeInsets.all(15),
        children: [
          
          CalendarCarousel(),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Text(
                'Section Title',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: .center,
                children: [
                  Text(
                    "Sorted ${sortLabel.toLowerCase()}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: .bold
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterMenu(context),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          InSyncList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              items: getTickets(context),
          ),
        ],
      ),
    );
  }
}
