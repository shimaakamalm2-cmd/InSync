import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/app_bar.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';
import 'package:insync/widgets/tag.dart';

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
                    title: "Feed the Dogs",
                    leadingAccessory: ListChevronAccessory(),
                    bottomAccessory: Row(
                      spacing: 5,
                      children: [
                        Tag(text: "Project Name", backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                        Tag(
                          text: 'Due in X days',
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          textColor: Colors.black,
                        ),
                        Tag(text: 'High', backgroundColor: InSyncColors.red),
                      ]
                    ),
                  ),
                  InSyncListItem(
                    title: "Feed the Cats",
                    leadingAccessory: ListChevronAccessory(),
                    bottomAccessory: Row(
                        spacing: 5,
                        children: [
                          Tag(text: "Project Name", backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                          Tag(
                            text: 'Due in X days',
                            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                            textColor: Colors.black,
                          ),
                          Tag(text: 'Medium', backgroundColor: InSyncColors.yellow),
                        ]
                    ),
                  ),
                  InSyncListItem(
                    title: "Feed the Chickens",
                    leadingAccessory: ListChevronAccessory(),
                    bottomAccessory: Row(
                        spacing: 5,
                        children: [
                          Tag(text: "Project Name", backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Theme.of(context).colorScheme.onInverseSurface),
                          Tag(
                            text: 'Due in X days',
                            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                            textColor: Colors.black,
                          ),
                          Tag(text: 'Low', backgroundColor: InSyncColors.green),
                        ]
                    ),
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
                    leadingAccessory: ListChevronAccessory(),
                    bottomAccessory: Row(
                        spacing: 5,
                        children: [
                          Text("2 tickets", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                        ]
                    ),
                  ),
                  InSyncListItem(
                    title: "Cat Feeding",
                    leadingAccessory: ListChevronAccessory(),
                    bottomAccessory: Row(
                        spacing: 5,
                        children: [
                          Text("221 tickets", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                        ]
                    ),
                  ),
                  InSyncListItem(
                    title: "Chicken Feeding",
                    leadingAccessory: ListChevronAccessory(),
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
