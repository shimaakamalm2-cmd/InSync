import "package:flutter/material.dart";
import "package:insync/model/ticket.dart";
import "package:insync/widgets/InSync_list.dart";
import "package:insync/widgets/tag.dart";

// this class is specifically for the priority section lists and late for the projects 
class BuildSection extends StatelessWidget {
  final String title;
  //before sending the tickets here , its mapped to InSyncListItem using ticketBuiler
  final List<InSyncListItem> tickets;

  const BuildSection({super.key, required this.title, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: InSyncList(
              title: title,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              items: tickets,
            ),
          
        ),
      ],
    );
  }
}
