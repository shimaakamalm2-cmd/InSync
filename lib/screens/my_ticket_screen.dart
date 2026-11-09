import "package:flutter/material.dart";
import "package:insync/widgets/InSync_list.dart";
import "package:insync/widgets/app_bar.dart";
import "package:insync/widgets/priority_tickets.dart";
import "package:insync/widgets/ticket_row.dart";
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
        ? LiquidGlassMenu(
          menuTitle: 'Sort by',
            items: const [
              LiquidGlassMenuItem(id: 'priority', title: 'Priority'),
              LiquidGlassMenuItem(
                id: 'alphabetical',
                title: 'Alphabetical',
              ),
              LiquidGlassMenuItem(id: 'project', title: 'Project'),
            ],
            onItemSelected: (id) {
              setState(() {
                switch (id) {
                  case 'priority':
                    sortLabel = 'Priority';
                    break;
                  case 'alphabetical':
                    sortLabel = 'Alphabetical';
                    break;
                  case 'project':
                    sortLabel = 'Project';
                    break;
                }
              });
            },
            icon: NativeLiquidGlassIcon.sfSymbol('line.3.horizontal.decrease.circle'),
            color: Theme.of(context).colorScheme.secondary,
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
          
          Container(
            color: Colors.grey[850],
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Calaendar things')],
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                children: [
                  Text(
                    sortLabel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterMenu(context),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(28),
            ),
            child: InSyncList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              items: getTickets(context),
            ),
          ),
        ],
      ),
    );
  }
}
