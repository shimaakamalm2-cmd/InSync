import "package:flutter/material.dart";
import "package:insync/model/project.dart";
import "package:insync/model/ticket.dart";
import "package:insync/model/user.dart";
import "package:insync/widgets/InSync_list.dart";
import "package:insync/widgets/SortingTickets.dart";
import "package:insync/widgets/app_bar.dart";
import "package:insync/widgets/buildSection.dart";
import "package:insync/widgets/calendar_carousel.dart";
import "package:insync/widgets/ticketBuilder.dart";
import 'package:native_liquid_glass/native_liquid_glass.dart';
import "package:uuid/uuid.dart";

class MyTicketScreen extends StatefulWidget {

  MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

//TODO - shimaa: implement by project logic - suggest removing alphabetical?

class _MyTicketScreenState extends State<MyTicketScreen> {
  String sortLabel = 'Alphabetically';
  late final List<Ticket> tickets = getSampleTickets();

  Widget _buildFilterMenu(BuildContext context) {
    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? LiquidGlassContainer(
            animateChanges: true,
            config: LiquidGlassConfig(cornerRadius: 80, interactive: true),
            child: LiquidGlassMenu(
              height: 37,
              menuTitle: 'Sort',
              items: [
                LiquidGlassMenuItem(
                  id: 'priority',
                  title: 'By priority',
                  icon: sortLabel == 'By priority'
                      ? NativeLiquidGlassIcon.sfSymbol('checkmark')
                      : null,
                ),
                LiquidGlassMenuItem(
                  id: 'alphabetical',
                  title: 'Alphabetically',
                  icon: sortLabel == 'Alphabetically'
                      ? NativeLiquidGlassIcon.sfSymbol('checkmark')
                      : null,
                ),
                LiquidGlassMenuItem(
                  id: 'project',
                  title: 'By project',
                  icon: sortLabel == 'By project'
                      ? NativeLiquidGlassIcon.sfSymbol('checkmark')
                      : null,
                ),
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
              icon: NativeLiquidGlassIcon.sfSymbol(
                'line.3.horizontal.decrease.circle',
              ),
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          )

          //fall back section if not ios
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
    // sorting the tickets
    final sortedTickets = TicketSorting.sortTickets(tickets,sortLabel,);
    //grouping the sorted tickets by priority ( if priority is selected)
    final groupedTickets = TicketSorting.groupByPriority(sortedTickets);
    return Scaffold(
      appBar: InSyncAppBar(title: 'My Tickets', showBackButton: true),
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
                      fontWeight: .bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterMenu(context),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          //---------sorting logic and display----
          if (sortLabel == 'By priority')
          //... refer to the grouped tickets (high, medium, low) 
            ...Priority.values.map((priority) {
              final priorityTickets = groupedTickets[priority] ?? [];

              if (priorityTickets.isEmpty) {
                return const SizedBox.shrink();
              }
              //builds each sectu=ion with its level as title
              return BuildSection(
                title: priority.priorityText,
                tickets: TicketListItemBuilder.build(priorityTickets),
              );
            })
          else
          //if not sorted by priority, just display the sorted tickets in a single list bas hatkoon alphabetically
            InSyncList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              items: TicketListItemBuilder.build(sortedTickets),
            ),
        ],
      ),
    );
  }
}

//example tickets for testing , use it instead of listitem thingy
//also fix due date to day count not wtv this is ( sorry its generated for testing lol) 
List<Ticket> getSampleTickets() {
  final now = DateTime.now();

  final projectA = Project('InSync', '-');
  final projectB = Project('SpendWise', '-');
  final projectC = Project('Elevate', '-');

  final userA = User(Uuid(), 'Shimaa');
  final userB = User(Uuid(), 'Ahmed');

  return [
    Ticket(
      Uuid(),
      projectA,
      Priority.high,
      'Fix login authentication',
      'Fix login bug',
      now.add(const Duration(days: 2)),
      now,
      now,
      userA,
      [userB],
    ),
    Ticket(
      Uuid(),
      projectB,
      Priority.medium,
      'Update dashboard UI',
      'Improve dashboard layout',
      now.add(const Duration(days: 5)),
      now,
      now,
      userB,
      [userA],
    ),
    Ticket(
      Uuid(),
      projectC,
      Priority.low,
      'Update documentation',
      'Add project documentation',
      now.add(const Duration(days: 10)),
      now,
      now,
      userA,
      [userB],
    ),
    Ticket(
      Uuid(),
      projectA,
      Priority.high,
      'Fix database connection',
      'Resolve connection issue',
      now.add(const Duration(days: 1)),
      now,
      now,
      userB,
      [userA],
    ),
    Ticket(
      Uuid(),
      projectB,
      Priority.medium,
      'Add profile settings',
      'Implement profile settings',
      now.add(const Duration(days: 7)),
      now,
      now,
      userA,
      [userB],
    ),
    Ticket(
      Uuid(),
      projectC,
      Priority.undetermined,
      'Review new feature',
      'Review feature proposal',
      now.add(const Duration(days: 14)),
      now,
      now,
      userB,
      [userA],
    ),
  ];
}
