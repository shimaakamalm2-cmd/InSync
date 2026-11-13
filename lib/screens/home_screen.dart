import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/my_ticket_screen.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/commen/app_bar.dart';
import 'package:insync/widgets/tickets/tag.dart';
import 'package:insync/widgets/tickets/ticket_Builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: InSyncAppBar(
        title: 'Home',
        showBackButton: false,
      ),

      body:
      ListView(
        // padding: const EdgeInsets.symmetric(vertical: 10.0),
        children: [
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ContributionCard(
              closedTickets: 83,
              dayOfWeek: 7,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: .symmetric(horizontal: 15.0),
            child: InSyncList(
              title: "Priority Tickets",
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
               items: TicketListItemBuilder.build(context, getSampleTickets().take(3).toList())
            ),
          ),

          SizedBox(height: 30),
          Container(
            padding: .symmetric(horizontal: 15.0),
            child: InSyncList(
              title: "My Projects",
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              items: [
                InSyncListItem(
                  title: "Dog Feeding",
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Text("2 tickets", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ]
                  ),
                ),
                InSyncListItem(
                  title: "Cat Feeding",
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Text("221 tickets", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ]
                  ),
                ),
                InSyncListItem(
                  title: "Chicken Feeding",
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Text("64,392 tickets", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                      ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
