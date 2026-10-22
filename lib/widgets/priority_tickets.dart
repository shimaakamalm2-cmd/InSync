import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'ticket_row.dart'; // Import your TicketRow widget

class PriorityTicketsCard extends StatelessWidget {
  const PriorityTicketsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TicketRow(
            title: 'Feed the Dogs',
            priorityText: '!!! High',
            priorityColor: InSyncColors.red,
            showDivider: true,
          ),


          // Second Row: Feed the Cats
          TicketRow(
            title: 'Feed the Cats',
            priorityText: '!! Medium',
            priorityColor: InSyncColors.yellow,
            showDivider: true,
          ),

          // Third Row: Feed the Chickens
          TicketRow(
            title: 'Feed the Chickens',
            priorityText: '! Low',
            priorityColor: InSyncColors.green,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}