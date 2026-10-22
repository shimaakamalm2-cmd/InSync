
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/Contribution_card.dart';
import 'package:insync/widgets/bottom_bav_bar.dart';
import 'package:insync/widgets/priority_tickets.dart';
import 'package:insync/widgets/project_list.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

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
              Icon(CupertinoIcons.settings_solid, color: Theme.of(context).colorScheme.onSurface,)
            ],
            actionsPadding: .directional(end: 20, start: 20),
            // stretch: true,
            // floating: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Expanded(child: Column(
                crossAxisAlignment: .center,
                mainAxisAlignment: .end,
                children: [
                  Text("Home", style: TextStyle(fontWeight: .bold), textAlign: .start,),
                ],
              ))
              ,
              expandedTitleScale: 2,
              collapseMode: .parallax,
              centerTitle: false,
              titlePadding: .directional(start: 20, end: 20, bottom: 10),
              stretchModes: [
                    .zoomBackground,
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
                  ContributionCard(closedTickets: 83, dayOfWeek: 7),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 7,
                    children: [
                      Container(
                        padding: .directional(start: 10, end: 10),
                        child: Text(
                          'Priority Tickets',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PriorityTicketsCard(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 7,
                    children: [
                      Container(
                        padding: .directional(start: 10, end: 10),
                        child: Text(
                          'My Projects',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ProjectList(),
                    ],
                  ),
                ],
              ),
            )
          ])
        ],
      ),
      bottomNavigationBar: NativeLiquidGlassUtils.supportsLiquidGlass
    ? LiquidGlassTabBar(
    items: const [
      LiquidGlassTabItem(label: 'Home', icon: NativeLiquidGlassIcon.sfSymbol('house')),
      LiquidGlassTabItem(label: 'Ticket', icon: NativeLiquidGlassIcon.sfSymbol('ticket')),
      LiquidGlassTabItem(label: 'Search', icon: NativeLiquidGlassIcon.sfSymbol('magnifyingglass')),
    ],
    currentIndex: 0,
    onTabSelected: (_) {},
    iosActionButton: .new(label: "New", icon: NativeLiquidGlassIcon.sfSymbol('plus'), iconSize: 19, selectedItemColor: Theme.of(context).colorScheme.primary ),
    selectedItemColor: Theme.of(context).colorScheme.primary,
    )
        : const PlaceholderNavBar()

    );
  }
}
