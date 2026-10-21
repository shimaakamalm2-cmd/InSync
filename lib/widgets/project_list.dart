import 'package:flutter/material.dart';
import 'package:insync/widgets/project_row.dart';

class ProjectList extends StatelessWidget {

  const ProjectList({super.key});

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
          ProjectRow(
            projectName: "mewedmm",
            ticketsLeft: 2,
            showDivider: true,
          ),

          ProjectRow(
            projectName: "mssemm",
            ticketsLeft: 221,
            showDivider: false,
          ),

        ],
      ),
    );
  }
}