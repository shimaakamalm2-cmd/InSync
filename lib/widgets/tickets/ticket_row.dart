import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Container(
                padding: .directional(top: 15, bottom: 15, start: 15),
                child: Column(
                  spacing: 7,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Row(
                      spacing: 5,
                      children: [
                        Tag(text : "Project Name" , backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Colors.black,),
                        Tag(text : "Due in X days" , backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Colors.black,),
                        Tag(text: priorityText, backgroundColor: priorityColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: .directional(end: 15),
                child: ExclusionFilter(
                  child:
                    Icon(
                      Icons.arrow_forward_ios_rounded, //tried to find ziad's arrow shape
                      color: InSyncColors.prominentItemColor,
                      size: 20,
                    ),
                )
              ),
            ],
          ),
          if (showDivider) ...[
            // const SizedBox(height: 10),
            Container(
              padding: .directional(start: 25),
              child: ExclusionFilter(
                child:
                Divider(
                  height: 2,
                  thickness: 1,
                  color: InSyncColors.dividerColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}