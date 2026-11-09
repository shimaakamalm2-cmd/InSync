
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/bottom_nav_bar.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 65,
        title: Text(
          'Home',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          NativeLiquidGlassUtils.supportsLiquidGlass ?
              LiquidGlassButton.icon(onPressed: (){}, icon: NativeLiquidGlassIcon.sfSymbol("gear")) :
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.settings_solid),
              ),
          SizedBox.fromSize(size: const Size(6, 1)),
          NativeLiquidGlassUtils.supportsLiquidGlass ?
          LiquidGlassMenu(
            items: const [
              LiquidGlassMenuItem(
                id: 'sample_ticket',
                title: 'Sample Ticket',
                icon: NativeLiquidGlassIcon.sfSymbol('ticket'),
              ),
            ],
            onItemSelected: (id) {
              if (id == "sample_ticket") {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: null,)));
              }
            },
            color: InSyncColors.secondary,
            icon: NativeLiquidGlassIcon.sfSymbol('ladybug'),
            menuTitle: "DEBUG",
          ) :
          PopupMenuButton(itemBuilder: (itemBuilder) {
            return [
              PopupMenuItem(
                child: Text('Sample Ticket'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: null,)));
                },
              ),
            ];
          })
        ],
        actionsPadding: .directional(end: 15),
        titleSpacing: 25,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.0,
              children: [
                ContributionCard(
                  closedTickets: 83,
                  dayOfWeek: 7,
                ),

                Column(
                  crossAxisAlignment: .start,
                  spacing: 7,
                  children: [
                    Container(
                      padding: .directional(start: 10, end: 10),
                      child: Text(
                        'Priority Tickets',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PriorityTicketsCard(),
                  ],
                ),

                Column(
                  crossAxisAlignment: .start,
                  spacing: 7,
                  children: [
                    Container(
                      padding: .directional(start: 10, end: 10),
                      child: Text(
                        'My Projects',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                     ProjectList(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const AppNavBar(),
    );
  }
}
