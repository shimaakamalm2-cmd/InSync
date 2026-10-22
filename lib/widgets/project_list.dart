import 'package:flutter/material.dart';
import 'package:insync/widgets/project_row.dart';

import '../colors.dart';

class ProjectList extends StatelessWidget {

  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .directional(top: 15, bottom: 15),
      decoration: BoxDecoration(
        
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProjectRow(
            projectName: "Dog Feeding",
            ticketsLeft: 2,
            showDivider: true,
          ),

          ProjectRow(
            projectName: "Cat Feeding",
            ticketsLeft: 221,
            showDivider: true,
          ),

          ProjectRow(
            projectName: "Chicken Feeding",
            ticketsLeft: 221,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}