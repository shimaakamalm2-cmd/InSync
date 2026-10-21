import 'package:flutter/material.dart';
import 'tag.dart';

class TicketRow extends StatelessWidget {
  final String title;
  final String priorityText;
  final Color priorityColor;
  final bool showDivider;

  const TicketRow({
    super.key,
    required this.title,
    required this.priorityText,
    required this.priorityColor,
    this.showDivider=true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 230, 230), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // arrow far right 
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, //tried to find ziad's arrow shape
                color: Colors.grey,
                size: 18,
              ),
            ],
          ),
          
         const SizedBox(height: 10),
          
          Row(
            children: [
              const Tag(text : "Project Name" , backgroundColor: Color.fromARGB(255, 146, 145, 145)),
              const SizedBox(width: 5),
              const Tag(text : "Due" , backgroundColor:  Color.fromARGB(255, 146, 145, 145)),
              const SizedBox(width: 5),
              Tag(text: priorityText, backgroundColor: priorityColor),
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              thickness: 0.8,
              color: Color.fromARGB(255, 133, 133, 133),
            ),
          ],
        ],
      ),
    );
  }
}