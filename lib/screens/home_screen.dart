
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/bottem_bav_bar.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            actions: [
              Icon(CupertinoIcons.settings_solid)
            ],
            actionsPadding: .directional(end: 20, start: 20),
            // stretch: true,
            // floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Expanded(child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .end,
                children: [
                  Text("Home", style: TextStyle(fontWeight: .bold), textAlign: .start,),
                ],
              ))
              ,
              expandedTitleScale: 1.9,
              collapseMode: .parallax,
              centerTitle: false,
              titlePadding: .directional(start: 20, end: 20, bottom: 10),
              stretchModes: [
                    .zoomBackground,
                    .zoomBackground
              ],
            ),
          ),
          
          SliverList.list(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Container( //its trying to make it SizedBox for some reason
                    height: 188,
                    width: double.infinity,
                    child: Card(
                      shadowColor: Colors.transparent,
                      color: InSyncColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  const Text(
                    'Priority tickets',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PriorityTicketsCard(),
                  const Text(
                    'My Projects',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ProjectList(),
                ],
              ),
            )
          ])
        ],
      ),
      bottomNavigationBar: const PlaceholderNavBar(),
    );
  }
}
