import "package:cupertino_native_better/components/popup_menu_button.dart";
import "package:cupertino_native_better/style/sf_symbol.dart";
import "package:flutter/material.dart";
import "package:insync/model/project.dart";
import "package:insync/model/ticket.dart";
import "package:insync/model/user.dart";
import "package:insync/widgets/InSync_list.dart";
import "package:insync/widgets/tickets/sorting_tickets.dart";
import "package:insync/widgets/tickets/buildSection.dart";
import "package:insync/widgets/calendar_carousel.dart";
import "package:insync/widgets/tickets/ticket_Builder.dart";
import 'package:native_liquid_glass/native_liquid_glass.dart';
import "package:uuid/uuid.dart";

import "../widgets/common/app_bar.dart";

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

String sortLabel = 'Alphabetically';
int _selectedCalIndex = 0;

class _MyTicketScreenState extends State<MyTicketScreen> {
  late final List<Ticket> tickets = getSampleTickets();

  Widget _buildFilterMenu(BuildContext context) {
    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? CNPopupMenuButton.icon(
            size: 30,
            buttonStyle: .clearGlass,
            buttonIcon: CNSymbol(
              sortLabel == 'Alphabetically'
                  ? 'line.3.horizontal.decrease.circle'
                  : 'line.3.horizontal.decrease.circle.fill',
              size: 15,
              mode: .monochrome,
            ),
            items: [
              CNPopupMenuItem(
                label: 'By priority',
                checked: sortLabel == 'By priority',
              ),
              CNPopupMenuItem(
                label: 'Alphabetically',
                checked: sortLabel == 'Alphabetically',
              ),
              CNPopupMenuItem(
                label: 'By project',
                checked: sortLabel == 'By project',
              ),
            ],
            onSelected: (id) {
              setState(() {
                switch (id) {
                  case 0:
                    sortLabel = 'By priority';
                    break;
                  case 1:
                    sortLabel = 'Alphabetically';
                    break;
                  case 2:
                    sortLabel = 'By project';
                    break;
                }
              });
            },
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
                value: 'By priority',
                child: Text('Priority'),
              ),
              const PopupMenuItem<String>(
                value: 'Alphabetical',
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<String>(
                value: 'by Project',
                child: Text('Project'),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    // sorting the tickets
    final sortedTickets = TicketSorting.sortTickets(tickets, sortLabel);
    //grouping the sorted tickets by priority ( if priority is selected)
    final groupedTickets = TicketSorting.groupByPriority(sortedTickets);
    final groupedProjectTickets = TicketSorting.groupByProjectName(
      sortedTickets,
    );
    return Scaffold(
      appBar: InSyncAppBar(title: 'My Tickets', showBackButton: true),
      body: ListView(
        padding: .only(top: 10),
        children: [
          CalendarCarousel(
            selectedIndex: _selectedCalIndex,
            onSelect: (index, date) {
              _selectedCalIndex = index;
            },
          ),
          ListView(
            padding: .symmetric(horizontal: 15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Text(
                    'Tickets Due',
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
                          fontSize: 13,
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
                    tickets: TicketListItemBuilder.build(
                      context,
                      priorityTickets,
                    ),
                  );
                })
              else if (sortLabel == 'By project')
                ...groupedProjectTickets.entries.map((entry) {
                  return BuildSection(
                    title: entry.key, //project name
                    tickets: TicketListItemBuilder.build(context, entry.value), //entry val is the list of tickets with that name
                  );
                })
              else
                //if not sorted by priority, just display the sorted tickets in a single list bas hatkoon alphabetically
                InSyncList(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  items: TicketListItemBuilder.build(context, sortedTickets),
                ),
            ],
          ),

          // To prevent clipping into the navigation bar at the end of the list
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

//---------------------example tickets for testing , use it instead of listitem thingy
List<Ticket> getSampleTickets() {
  final now = DateTime.now();
  const uuid = Uuid();

  final projectA = Project(
    uuid.v4(),
    'InSync',
    '-',
    'Summary',
    now,
    3,
  );

  final projectB = Project(
    uuid.v4(),
    'SpendWise',
    '-',
    'Summary',
    now,
    3,
  );

  final projectC = Project(
    uuid.v4(),
    'Elevate',
    '-',
    'Summary',
    now,
    3,
  );

  final userA = UserModel(
    id: uuid.v4(),
    name: 'Shimaa',
    email: 'shimaa@example.com',
    role: UserRole.depHead,
    orgId: 'org1',
  );

  final userB = UserModel(
    id: uuid.v4(),
    name: 'Ahmed',
    email: 'ahmed@example.com',
    role: UserRole.employee,
    orgId: 'org1',
  );

  return [
    Ticket(
      uuid.v4(),
      projectA,
      Priority.high,
      'Fix login authentication',
      'Fix login bug',
      now.add(const Duration(days: 2)),
      now,
      now,
      userA,
      [userB],
      true,
    ),
    Ticket(
      uuid.v4(),
      projectB,
      Priority.medium,
      'Update dashboard UI',
      'Improve dashboard layout',
      now.add(const Duration(days: 5)),
      now,
      now,
      userB,
      [userA],
      false,
    ),
    Ticket(
      uuid.v4(),
      projectC,
      Priority.low,
      'Update documentation',
      'Add project documentation',
      now.add(const Duration(days: 10)),
      now,
      now,
      userA,
      [userB],
      true, // isConfirmed
    ),
    Ticket(
      uuid.v4(),
      projectA,
      Priority.high,
      'Fix database connection',
      'Resolve connection issue',
      now.add(const Duration(days: 1)),
      now,
      now,
      userB,
      [userA],
      false,
    ),
    Ticket(
      uuid.v4(),
      projectB,
      Priority.medium,
      'Add profile settings',
      'Implement profile settings',
      now.add(const Duration(days: 7)),
      now,
      now,
      userA,
      [userB],
      true,
    ),
    Ticket(
      uuid.v4(),
      projectC,
      Priority.undetermined,
      'Review new feature',
      'Review feature proposal',
      now.add(const Duration(days: 14)),
      now,
      now,
      userB,
      [userA],
      false,
    ),
  ];
}