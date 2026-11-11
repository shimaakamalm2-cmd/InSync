import 'package:flutter/material.dart';
import 'package:insync/screens/home_screen.dart';
import 'package:insync/screens/my_ticket_screen.dart';
import 'package:insync/screens/placeholder_page.dart';
import 'package:insync/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _selectedIndex = 0;

class StartPage extends StatefulWidget {

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<Widget> tabs = [HomeScreen(), MyTicketScreen(), PlaceholderPage()];

  StartPage({super.key}) {
    prefs.then((value) {
      _selectedIndex = value.getInt("tab_index") ?? _selectedIndex;
    });
  }

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    super.initState();
    widget.prefs.then((value) {
      setState(() {
        _selectedIndex = value.getInt("tab_index") ?? _selectedIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // TODO: Resolve Navigator issue
      // body: Navigator(
      //   pages: [
      //
      //   ],
      //   onGenerateRoute: (page) {
      //     Widget assignedPage = widget.tabs[_selectedIndex];
      //     if (page.name == 'ticket_detail') assignedPage = TicketDetailPage();
      //     return MaterialPageRoute(builder: (context) {
      //       return assignedPage;
      //     });
      //   },
      // ),
      body: widget.tabs[_selectedIndex],
      bottomNavigationBar: AppNavBar(selectedIndex: _selectedIndex, onTabChange: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },),
    );
  }
}