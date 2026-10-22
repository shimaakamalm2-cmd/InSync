import 'package:flutter/material.dart';

import '../colors.dart';

class ProjectRow extends StatelessWidget{
  final String projectName;
  final int ticketsLeft;
  final bool showDivider;
  const ProjectRow({super.key , required this.projectName , required this.ticketsLeft , this.showDivider=true,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .directional(start: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Container(
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$ticketsLeft tickets left',
                      style: TextStyle(
                        color: InSyncColors.secondaryText.light,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: .directional(end: 15),
                child: ExclusionFilter(
                  child:
                  const Icon(
                    Icons.arrow_forward_ios, //tried to find ziad's arrow shape
                    color: InSyncColors.prominentItemColor,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 12),
            Container(
              padding: .directional(start: 8),
              child: ExclusionFilter(
                child:
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  color: InSyncColors.dividerColor,
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}