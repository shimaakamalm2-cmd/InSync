import 'package:flutter/material.dart';

class ProjectRow extends StatelessWidget{
  final String projectName;
  final int ticketsLeft;
  final bool showDivider;
  const ProjectRow({super.key , required this.projectName , required this.ticketsLeft , this.showDivider=true,});

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
                projectName,
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
          Row(
            children: [
              Text(
                '$ticketsLeft tickets left',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
         const SizedBox(height: 10),
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