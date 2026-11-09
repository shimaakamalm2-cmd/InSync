
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/app_bar.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: InSyncAppBar(
        title: 'Home',
        showBackButton: false,
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
    );
  }
}
