import 'dart:ffi';

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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Row(
                      spacing: 0,
                      children: [
                        const Tag(text : "Project Name" , backgroundColor: Color.fromARGB(62, 83, 83, 83), textColor: Colors.black,),
                        const SizedBox(width: 5),
                        const Tag(text : "Due" , backgroundColor: Color.fromARGB(62, 83, 83, 83), textColor: Colors.black,),
                        const SizedBox(width: 5),
                        Tag(text: priorityText, backgroundColor: priorityColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: .directional(end: 15),
                child: BackdropFilter(
                  filterConfig: .blur(),
                  blendMode: .exclusion,
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded, //tried to find ziad's arrow shape
                    color: Color.fromARGB(217, 34, 34, 34),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            // const SizedBox(height: 10),
            Container(
              padding: .directional(start: 25),
              child: BackdropFilter(
                filterConfig: .blur(),
                blendMode: .exclusion,
                child:
                const Divider(
                  height: 2,
                  thickness: 1,
                  color: Color.fromARGB(99, 55, 55, 55),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}