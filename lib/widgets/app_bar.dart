import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insync/model/ticket.dart';
import 'package:insync/model/project.dart';
import 'package:insync/model/user.dart';
import 'package:uuid/uuid.dart';

const _defaultDebugPropertiesValue = true;

final Project _costBreakdownProject = Project(
  'Cost Breakdown',
  'Analyze and improve the cost breakdown of products.',
);
final Project _mobileAppProject = Project(
  'InSync Mobile',
  'Tasks for improving the InSync mobile app.',
);
final User _sampleAssignee = User(Uuid(), 'Shimaa');
final User _sampleReporter = User(Uuid(), 'Ahmed');

final List<Ticket> sampleTickets = [
  Ticket(
    Uuid(),
    _costBreakdownProject,
    Priority.high,
    'Review product costs',
    'Check supplier pricing and update the cost breakdown for this quarter.',
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 2)),
    _sampleAssignee,
    [_sampleReporter],
  ),
  Ticket(
    Uuid(),
    _mobileAppProject,
    Priority.medium,
    'Polish ticket details screen',
    'Improve the ticket detail layout and make long descriptions wrap correctly.',
    DateTime.now().add(const Duration(days: 7)),
    DateTime.now(),
    DateTime.now().subtract(const Duration(days: 1)),
    _sampleReporter,
    [_sampleAssignee],
  ),
];

class InSyncAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool debugProperties;

  const InSyncAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.debugProperties = _defaultDebugPropertiesValue,
  });

  @override
  State<StatefulWidget> createState() => InSyncAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class InSyncAppBarState extends State<InSyncAppBar> {

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int selectedTabIndex = -1;

  @override
  void initState() {
    super.initState();
    prefs.then((onValue) {
      setState(() {
        selectedTabIndex = onValue.getInt("tab_index") ?? -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      centerTitle: false,
      // backgroundColor: Colors.transparent,
      toolbarHeight: 65,
      automaticallyImplyLeading: widget.showBackButton,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        NativeLiquidGlassUtils.supportsLiquidGlass
            ? LiquidGlassButton.icon(
                onPressed: () {},
                icon: NativeLiquidGlassIcon.sfSymbol('gear'),
              )
            : IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.settings_solid),
              ),
        SizedBox.fromSize(
          size: const Size(6, 1),
        ),

        // DEBUG

        if (widget.debugProperties)

        NativeLiquidGlassUtils.supportsLiquidGlass
          ? LiquidGlassMenu.icon(
              items: [
                const LiquidGlassMenuItem(
                  id: 'sample_ticket',
                  title: 'Show sample ticket',
                  icon: NativeLiquidGlassIcon.sfSymbol('ticket'),
                ),
                LiquidGlassMenuItem(
                    id: 'tab_index',
                    title: 'Default tab bar index',
                    children: [
                      LiquidGlassMenuItem(
                        id: 'tab_index_0',
                        title: 'Home',
                        icon: selectedTabIndex == 0 ? const NativeLiquidGlassIcon.sfSymbol('checkmark.circle.fill') : NativeLiquidGlassIcon.sfSymbol('circlebadge'),
                      ),
                      LiquidGlassMenuItem(
                        id: 'tab_index_1',
                        title: 'My Tickets',
                        icon: selectedTabIndex == 1 ? const NativeLiquidGlassIcon.sfSymbol('checkmark.circle.fill') : NativeLiquidGlassIcon.sfSymbol('circlebadge'),
                      ),
                      LiquidGlassMenuItem(
                        id: 'tab_index_2',
                        title: 'Search',
                        icon: selectedTabIndex == 2 ? const NativeLiquidGlassIcon.sfSymbol('checkmark.circle.fill') : NativeLiquidGlassIcon.sfSymbol('circlebadge'),
                      ),
                    ]
                )
              ],
              onItemSelected: (id) {
                if (id == 'sample_ticket') {
                  // TODO: Resolve Navigator issue
                  // Navigator.pushNamed(
                  //   context,
                  //   "ticket_detail"
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: sampleTickets[0])));
                } else if (id.contains('tab_index_')) {
                  prefs.then((onValue) {
                    setState(() {
                      onValue.setInt("tab_index", int.parse(id[id.length - 1]));
                      selectedTabIndex = int.parse(id[id.length - 1]);
                    });
                  });
                }
              },
              color: InSyncColors.secondary,
              icon: NativeLiquidGlassIcon.sfSymbol('ladybug'),
              menuTitle: 'DEBUG',
            )

        : PopupMenuButton(
          itemBuilder: (itemBuilder) {
            return [
              PopupMenuItem(
                child: const Text('Sample Ticket'),
                onTap: () {
                  // TODO: Resolve Navigator issue
                  // Navigator.pushNamed(
                  //   context,
                  //   "ticket_detail",
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => TicketDetailPage(ticket: sampleTickets[0])));
                },
              ),
            ];
          },
        )
      ],
      actionsPadding:
          const EdgeInsetsDirectional.only(end: 15),
      titleSpacing: 25,
    );
  }
}
