import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/my_ticket_screen.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/app_bar.dart';
import 'package:insync/widgets/tag.dart';

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
              items: [
                InSyncListItem(
                  title: getSampleTickets()[0].title,
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Tag(text: getSampleTickets()[0].belongingProject.name, backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                        Tag(
                          text: 'Due in ${getSampleTickets()[0].dueDate.difference(DateTime.now()).inDays}d',
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          textColor: Colors.black,
                        ),
                        Tag(text: getSampleTickets()[0].priorityText, backgroundColor: getSampleTickets()[0].priority.getPriorityColor()),
                      ]
                  ),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: getSampleTickets()[0])));
                  },
                ),
                InSyncListItem(
                  title: getSampleTickets()[1].title,
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Tag(text: getSampleTickets()[1].belongingProject.name, backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                        Tag(
                          text: 'Due in ${getSampleTickets()[1].dueDate.difference(DateTime.now()).inDays}d',
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          textColor: Colors.black,
                        ),
                        Tag(text: getSampleTickets()[1].priorityText, backgroundColor: getSampleTickets()[1].priority.getPriorityColor(), textColor: getSampleTickets()[1].priority == .medium ? InSyncColors.black : InSyncColors.white,),
                      ]
                  ),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: getSampleTickets()[1])));
                  },
                ),
                InSyncListItem(
                  title: getSampleTickets()[2].title,
                  trailingAccessory: ListChevronAccessory(),
                  bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Tag(text: getSampleTickets()[2].belongingProject.name, backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                        Tag(
                          text: 'Due in ${getSampleTickets()[2].dueDate.difference(DateTime.now()).inDays}d',
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          textColor: Colors.black,
                        ),
                        Tag(text: getSampleTickets()[2].priorityText, backgroundColor: getSampleTickets()[2].priority.getPriorityColor()),
                      ]
                  ),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: getSampleTickets()[2])));
                  },
                ),
              ],
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
