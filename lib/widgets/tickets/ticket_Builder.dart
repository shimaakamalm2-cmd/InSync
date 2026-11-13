import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/model/ticket.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/tickets/tag.dart';

// the class takes the ticket objects and puts displays it with appropriate UI
class TicketListItemBuilder {
  static List<InSyncListItem> build(BuildContext context, List<Ticket> tickets) {
    return tickets.map((ticket) {
      return InSyncListItem(
        title: ticket.title,
        trailingAccessory: ListChevronAccessory(),
        spacing: 12,
        leadingAccessory: Container(
            padding: .all(2),
            child: Image.asset("assets/images/logo.png", width: 46, height: 46)),
        bottomAccessory: Row(
          spacing: 5,
          children: [
            Tag(
              text: ticket.belongingProject.name,
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              textColor: Colors.white
            ),
            Tag(
              text: 'Due in ${ticket.dueDate.difference(DateTime.now()).inDays}d', //TODO :change it to hard code
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              textColor: Colors.white,
            ),
            Tag(
              text: ticket.priorityText,
              backgroundColor: ticket.priority.getPriorityColor(),
              textColor: ticket.priority == Priority.medium ||
                      ticket.priority == Priority.undetermined
                  ? Colors.black
                  : Colors.white,
            ),
          ],
        ),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: ticket)));
        },
      );
    }).toList();
  }
  
}
