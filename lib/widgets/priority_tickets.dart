import 'package:flutter/material.dart';
import 'ticket_row.dart'; // Import your TicketRow widget

class PriorityTicketsCard extends StatelessWidget {
  const PriorityTicketsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color: const Color.fromARGB(215, 239, 239, 239),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TicketRow(
            title: 'Study',
            priorityText: '!!! High',
            priorityColor: const Color(0xFFFF3B30),
            showDivider: true,
          ),


          // Second Row: Feed the Cats
          TicketRow(
            title: 'Eat',
            priorityText: '!! Medium',
            priorityColor: const Color(0xFFFFCC00),
            showDivider: true,
          ),

          // Third Row: Feed the Chickens
          TicketRow(
            title: 'Die',
            priorityText: '! Low',
            priorityColor: const Color(0xFF34C759),
            showDivider: false,
          ),
        ],
      ),
    );
  }
}