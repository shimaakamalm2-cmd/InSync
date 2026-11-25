import 'package:cupertino_native_better/components/date_picker.dart';
import 'package:cupertino_native_better/components/pop_up_button.dart';
import 'package:cupertino_native_better/cupertino_native.dart'
    hide LiquidGlassContainer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insync/model/department.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/button.dart';
import 'package:insync/widgets/common/GlassSnackBar.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';
import 'package:uuid/v6.dart';

/// Invite page is meant to modally presented

final List<Department> _sampleDepartments = [
  Department(id: 'dep1', name: 'Software Engineering', headId: 'user1'),
  Department(id: 'dep2', name: 'Human Resources', headId: 'user2'),
  Department(id: 'dep3', name: 'Quality Assurance', headId: null),
  Department(id: 'dep4', name: 'Information Technology', headId: 'user3'),
  Department(id: 'dep5', name: 'Finance', headId: null),
];

class InvitePage extends StatefulWidget {
  final isModal = false;

  const InvitePage({super.key});

  @override
  State<StatefulWidget> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
    with SingleTickerProviderStateMixin {

  Department? selectedDepartment;

  String? generatedCode;
  DateTime expiryDate = .now().add(Duration(days: 7));
  bool teamLead = false;

  late final animation = AnimationController(vsync: this, duration: Duration(seconds: 20));

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: .tight(.fromHeight(460)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer
            .withValues(alpha: 1, red: 0.09, green: 0.09, blue: 0.09),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          // Stops that weird primary color bleeding when scrolling.
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 75,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: .only(bottom: 2),
            // Keeps the Flutter title in its own composited layer
            // to avoid hiding when a native UIKit/SwiftUI view
            // is rendered in view
            child: LiquidGlassContainer(
              config: .new(
                effect: .regular,
                shape: .custom,
                backgroundColor: Colors.transparent,
                customPath: [.close()],
                customPathSize: Size(10, 10),
              ),
              child: Text(
                "Invite",
                style: .new(fontWeight: .bold, fontSize: 23),
              ),
            ),
          ),
          actions: [
            GlassButton(SFSymbolName: "clock.fill", onPressed: () {}),
            SizedBox(width: 10),
            GlassButton(
              SFSymbolName: "xmark",
              size: 17,
              onPressed: () {
                if (Navigator.canPop(context)) Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding: const EdgeInsetsDirectional.only(end: 15),
          titleSpacing: 25,
        ),
        body: ListView(
          padding: .symmetric(horizontal: 15),
          clipBehavior: .none,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 15),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: .symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: .all(.circular(80)),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        GlassFriendlyBoundary(
                          child: SingleChildScrollView(
                            child: SelectableText(
                              generatedCode ??
                                  "Generated code will appear here.",
                              style: .new(
                                fontWeight: .w500,
                                color: generatedCode == null
                                    ? Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                    : null,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CNButton.icon(
                  onPressed: generatedCode == null
                      ? null
                      : () {
                          Clipboard.setData(.new(text: generatedCode!));
                          if (defaultTargetPlatform == .iOS) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              GlassSnackBar(
                                text: "Copied to clipboard",
                                animation: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInCubic,
                                ),
                              ),
                            );
                          }
                        },
                  icon: CNSymbol("link", size: 16),
                  config: .new(interaction: true, style: .prominentGlass),
                ),
              ],
            ),
            SizedBox(height: 30),

            GlassFriendlyBoundary(
              child: InSyncList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                items: [
                  InSyncListItem(
                    title: "Expires",
                    // trailingAccessory: Text(
                    //   DateFormat.yMMMEd().format(
                    //     DateTime.now().add(Duration(days: 7)),
                    //   ),
                    //   style: .new(
                    //     color: Theme.of(context).colorScheme.onSurfaceVariant,
                    //   ),
                    // ),
                    trailingAccessory: Row(
                      children: [
                        CNDatePicker(
                          style: .automatic,
                          mode: .dateAndTime,
                          value: expiryDate,
                          onChanged: (newDate) {
                            expiryDate = newDate;
                          },
                        ),
                      ],
                    ),
                  ),
                  InSyncListItem(
                    title: "Department",
                    trailingAccessory: CNPopUpButton<Department?>(
                      height: 16,
                      value: selectedDepartment,
                      items: [
                        const CNPopUpButtonItem(
                          value: null,
                          label: 'Select department',
                          enabled: false
                        ),
                        for (final department in _sampleDepartments)
                          CNPopUpButtonItem(
                            value: department,
                            label: department.name,
                          ),
                      ],
                      onChanged: (Department? department) {
                        setState(() {
                          selectedDepartment = department;
                        });
                      },
                    ),
                  ),
                  InSyncListItem(
                    title: "Team lead",
                    trailingAccessory: Padding(
                      padding: .only(right: 15),
                      child: CNSwitch(
                        height: 22,
                        value: teamLead,
                        onChanged: (newValue) {
                          teamLead = newValue;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ActionButton(
              label: "Create Invite",
              onPressed: () {
                setState(() {
                  generatedCode = UuidV6().generate();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? SFSymbolName;
  final double size;

  const GlassButton({
    super.key,
    this.onPressed,
    this.SFSymbolName,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? CNButton.icon(
            icon: CNSymbol(SFSymbolName ?? "square.dashed", size: size),
            onPressed: onPressed,
          )
        : FilledButton.icon(
            onPressed: onPressed,
            label: Text("Dismiss"),
            icon: Icon(Icons.import_contacts_sharp),
          );
  }
}

class GlassFriendlyBoundary extends StatelessWidget {
  final Widget child;

  const GlassFriendlyBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NativeLiquidGlassUtils.supportsLiquidGlass
        ? LiquidGlassContainer(
            config: .new(
              effect: .regular,
              shape: .custom,
              backgroundColor: Colors.transparent,
              customPath: [.close()],
              customPathSize: Size(10, 10),
            ),
            child: child,
          )
        : child;
  }
}
