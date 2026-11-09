import 'package:flutter/material.dart';
import 'package:insync/screens/home_screen.dart';
import 'package:insync/screens/my_tickets.dart';
import 'package:insync/screens/placeholder_page.dart';
import 'package:insync/widgets/bottom_nav_bar.dart';

class StartPage extends StatefulWidget {

  int selectedIndex = 0;
  List<Widget> tabs = [HomeScreen(), MyTickets(), PlaceholderPage()];

  StartPage({super.key,});

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.tabs[widget.selectedIndex],
      bottomNavigationBar: AppNavBar(selectedIndex: widget.selectedIndex, onTabChange: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },),
    );
  }
}