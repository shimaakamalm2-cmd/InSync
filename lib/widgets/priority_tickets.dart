import 'package:flutter/material.dart';
import 'ticket_row.dart'; // Import your TicketRow widget

class PriorityTicketsCard extends StatelessWidget {
  const PriorityTicketsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        
        color: const Color.fromARGB(255, 233, 230, 230), 
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TicketRow(
            title: 'study',
            priorityText: '!!! High',
            priorityColor: const Color(0xFFFF3B30),
            showDivider: true,
          ),


          // Second Row: Feed the Cats
          TicketRow(
            title: 'eat',
            priorityText: '!! Medium',
            priorityColor: const Color(0xFFFFCC00),
            showDivider: true,
          ),

          // Third Row: Feed the Chickens
          TicketRow(
            title: 'die',
            priorityText: '! Low',
            priorityColor: const Color(0xFF34C759),
            showDivider: false,
          ),
        ],
      ),
    );
  }
}