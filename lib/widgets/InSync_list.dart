import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/tag.dart';

class InSyncList extends StatefulWidget {
  final List<InSyncListItem>? items;

  final bool isLoading;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  InSyncList({
    super.key,
    this.items,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _InSyncListState();
}

class _InSyncListState extends State<InSyncList> {
  @override
  Widget build(BuildContext context) {
    //added loading since its statful
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      padding: widget.padding,

      itemCount: widget.items?.length ?? 0,
      itemBuilder: (context, index) {
        return widget.items![index];
      },
    );
  }
}

class InSyncListItem extends StatefulWidget {
  final String? title;
  final String? subtext;

  final Widget? leadingAccessory;
  final Widget? trailingAccessory;
  final Widget? bottomAccessory;

  final bool showDivider;

  final EdgeInsetsGeometry? padding;
  final double spacing;

  InSyncListItem({
    super.key,
    this.title,
    this.subtext,
    this.leadingAccessory,
    this.trailingAccessory,
    this.bottomAccessory,
    this.showDivider = true,
    this.padding,
    this.spacing = 5.0,
  });

  @override
  State<StatefulWidget> createState() => _InSyncListItemState();
}

class _InSyncListItemState extends State<InSyncListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // accupy vertical space as u need
      children: [
        Padding(
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.leadingAccessory != null)
                Padding(
                  padding: EdgeInsets.only(right: widget.spacing),
                  child: widget.leadingAccessory,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.title != null)
                      (Text(
                        widget.title!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),

                    if (widget.subtext != null)
                      Text(
                        widget.subtext!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    if (widget.bottomAccessory != null) ...[
                      SizedBox(height: widget.spacing),
                      widget.bottomAccessory!,
                    ],
                  ],
                ),
              ),

              if (widget.trailingAccessory != null)
                Padding(
                  padding: EdgeInsets.only(left: widget.spacing),
                  child: widget.trailingAccessory,
                ),
            ],
          ),
        ),
        if (widget.showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(height: 1, thickness: 0.8, color: Color(0xFFE0E0E0)),
          ),
      ],
    );
  }
}

List<InSyncListItem> getTickets(BuildContext context) {
  return [
    InSyncListItem(
      title: 'Fix login issue',

      bottomAccessory: Row(
        spacing: 5,
        children: [
          Tag(text : "Project Name" , backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, textColor: Colors.black,),
          Tag(text: 'Due in X days',backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,textColor: Colors.black,),
          Tag(text: 'High Priority', backgroundColor: InSyncColors.red),
        ],
      ),

      trailingAccessory: ExclusionFilter(
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: InSyncColors.prominentItemColor,
          size: 20,
        ),
      ),
    ),
    InSyncListItem(
      title: 'Update user profile page',
      bottomAccessory: Row(
        spacing: 5,
        children: [
          Tag(
            text: 'Project Name',
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            textColor: Colors.black,
          ),
          Tag(
            text: 'Due in X days',
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            textColor: Colors.black,
          ),
          Tag(text: 'Medium Priority', backgroundColor: Colors.orange),
        ],
      ),
      trailingAccessory: ExclusionFilter(
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: InSyncColors.prominentItemColor,
          size: 20,
        ),
      ),
    ),
  ];
}
