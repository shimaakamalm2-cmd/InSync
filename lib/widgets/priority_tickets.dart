import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'ticket_row.dart'; 


class PriorityTicketsCard extends StatelessWidget {
  const PriorityTicketsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = getPriorityTickets();

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return tickets[index];
        },
      ),
    );
  }
}


List <TicketRow> getPriorityTickets() {
  return [
    TicketRow(
      title: 'Feed the Dogs',
      priorityText: '!!! High',
      priorityColor: InSyncColors.red,
      showDivider: true,
    ),
    TicketRow(
      title: 'Feed the Cats',
      priorityText: '!! Medium',
      priorityColor: InSyncColors.yellow,
      showDivider: true,
    ),
    TicketRow(
      title: 'Feed the Chickens',
      priorityText: '! Low',
      priorityColor: InSyncColors.green,
      showDivider: false,
    ),
  ];
}