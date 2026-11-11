
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/model/ticket.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/tag.dart';

// the class takes the ticket objects and puts displays it with appropriate UI
class TicketListItemBuilder {
  static List<InSyncListItem> build(List<Ticket> tickets) {
    return tickets.map((ticket) {
      return InSyncListItem(
        title: ticket.title,
        leadingAccessory: ListChevronAccessory(),
        bottomAccessory: Row(
          spacing: 5,
          children: [
            Tag(
              text: ticket.belongingProject.name,
              backgroundColor: InSyncColors.genericSecondaryComponent.dark,
              textColor: Colors.white
            ),
            Tag(
              text: ticket.dueDate.toString().split(' ')[0], //TODO :change it to hard code
              backgroundColor: InSyncColors.genericSecondaryComponent.dark,
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
      );
    }).toList();
  }
  
}
