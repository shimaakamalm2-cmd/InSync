import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/ticket_detail.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class InSyncAppBar extends material.StatelessWidget implements material.PreferredSizeWidget{
  final String title;
  final bool showBackButton;

  const InSyncAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });
  @override
material.Size get preferredSize => const material.Size.fromHeight(65);

  @override
  material.Widget build(material.BuildContext context) {
    return material.AppBar(
      centerTitle: false,
      backgroundColor: material.Colors.transparent,
      toolbarHeight: 65,
      automaticallyImplyLeading: showBackButton,
      title: material.Text(
        title,
        style: material.TextStyle(
          color: material.Theme.of(context).colorScheme.onSurface,
          fontSize: 26,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      actions: [
        NativeLiquidGlassUtils.supportsLiquidGlass
            ? LiquidGlassButton.icon(
                onPressed: () {},
                icon: NativeLiquidGlassIcon.sfSymbol('gear'),
              )
            : material.IconButton(
                onPressed: () {},
                icon: const material.Icon(CupertinoIcons.settings_solid),
              ),
        material.SizedBox.fromSize(
          size: const material.Size(6, 1),
        ),
        NativeLiquidGlassUtils.supportsLiquidGlass
            ? LiquidGlassMenu(
                items: const [
                  LiquidGlassMenuItem(
                    id: 'sample_ticket',
                    title: 'Sample Ticket',
                    icon: NativeLiquidGlassIcon.sfSymbol('ticket'),
                  ),
                ],
                onItemSelected: (id) {
                  if (id == 'sample_ticket') {
                    material.Navigator.push(
                      context,
                      material.MaterialPageRoute(
                        builder: (builder) =>
                            TicketDetailPage(ticket: null),
                      ),
                    );
                  }
                },
                color: InSyncColors.secondary,
                icon: NativeLiquidGlassIcon.sfSymbol('ladybug'),
                menuTitle: 'DEBUG',
              )
            : material.PopupMenuButton(
                itemBuilder: (itemBuilder) {
                  return [
                    material.PopupMenuItem(
                      child: const material.Text('Sample Ticket'),
                      onTap: () {
                        material.Navigator.push(
                          context,
                          material.MaterialPageRoute(
                            builder: (builder) =>
                                TicketDetailPage(ticket: null),
                          ),
                        );
                      },
                    ),
                  ];
                },
              ),
      ],
      actionsPadding:
          const material.EdgeInsetsDirectional.only(end: 15),
      titleSpacing: 25,
    );
  }
}
