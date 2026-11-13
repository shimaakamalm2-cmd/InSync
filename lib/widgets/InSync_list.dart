import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/widgets/tickets/tag.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

class InSyncList extends StatefulWidget {
  final List<InSyncListItem>? items;

  final bool isLoading;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final String? title;

  const InSyncList({
    super.key,
    this.items,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.title
  });

  @override
  State<StatefulWidget> createState() => _InSyncListState();
}

const double _listBorderRadius = 26;

class _InSyncListState extends State<InSyncList> {
  @override
  Widget build(BuildContext context) {
    // added loading since its stateful
    if (widget.isLoading) {
      return NativeLiquidGlassUtils.supportsLiquidGlass ? const LiquidGlassActivityIndicator() : const Center(child: CircularProgressIndicator());
    }

    return Column(
        crossAxisAlignment: .start,
        spacing: 5,
        children: [
          if (widget.title != null)
            Container(
                padding: .directional(start: 15),
                child: Text(widget.title!, style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme.onSurfaceVariant,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ))),
          ListView.builder(
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            padding: widget.padding,

            itemCount: widget.items?.length ?? 0,
            itemBuilder: (context, index) {
              if (widget.items?.length == 1) {
                return widget.items![index].onTap != null ?
                InkResponse(
                  onTap: () {
                    widget.items![index].onTap?.call();
                  },
                  radius: 800,
                  containedInkWell: true,
                  highlightShape: .rectangle,
                  
                  splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                  child: BackdropFilter(
                    // TODO: Temporarily disabled while until the backdrop effect issue is resolved
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    blendMode: .srcOver,
                    enabled: false,
                    child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .all(.circular(_listBorderRadius))),
                      child: widget.items![index],
                    ),
                  ),
                ) :
                BackdropFilter(
                  // TODO: Also temporarily disabled while until the backdrop effect issue is resolved
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  enabled: false,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .all(.circular(_listBorderRadius))),
                    child: widget.items![index],
                  ),
                );
              } else if (index == widget.items!.length - 1) {
                return widget.items![index].onTap != null ?
                InkResponse(
                  onTap: () {
                    widget.items![index].onTap?.call();
                  },
                  radius: 800,
                  containedInkWell: true,
                  highlightShape: .rectangle,
                  
                  splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                  borderRadius: .vertical(bottom: .circular(_listBorderRadius)),
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .directional(bottomStart: .circular(_listBorderRadius), bottomEnd: .circular(_listBorderRadius))),
                    child: widget.items![index],
                  ),
                ) :
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .directional(bottomStart: .circular(_listBorderRadius), bottomEnd: .circular(_listBorderRadius))),
                  child: widget.items![index],
                );
              } else {
                return Column(
                  children: [
                    if (index == 0)
                      widget.items![index].onTap != null ?
                      InkResponse(
                        borderRadius: .vertical(top: .circular(_listBorderRadius)),
                        onTap: () {
                          widget.items![index].onTap?.call();
                        },
                        radius: 800,
                        containedInkWell: true,
                        highlightShape: .rectangle,
                        
                        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .directional(topStart: .circular(_listBorderRadius), topEnd: .circular(_listBorderRadius))),
                          child: widget.items![index],
                        ),
                      ) :
                      Container(
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: .directional(topStart: .circular(_listBorderRadius), topEnd: .circular(_listBorderRadius))),
                        child: widget.items![index],
                      ),
                    if (index != 0)
                      widget.items![index].onTap != null ?
                      InkResponse(
                        onTap: () {
                          widget.items![index].onTap?.call();
                        },
                        radius: 800,
                        containedInkWell: true,
                        highlightShape: .rectangle,
                        
                        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                        child: Container(
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer),
                          child: widget.items![index],
                        ),
                      ) :
                      Container(
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer),
                        child: widget.items![index],
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child:
                        ExclusionFilter(
                          child: Divider(
                            height: 0,
                            thickness: 0.3,
                            color: Color.fromARGB(180, 94, 94, 94)
                          ),
                        )
                    ),
                  ],
                );
              }
            },
          ),
        ],
    );
  }
}

class InSyncListItem extends StatefulWidget {
  final String? title;
  final String? subtext;
  final bool boldTitle;

  final Widget? leadingAccessory;
  final Widget? trailingAccessory;
  final Widget? bottomAccessory;

  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Function()? onTap;

  const InSyncListItem({
    super.key,
    this.title,
    this.boldTitle = false,
    this.subtext,
    this.leadingAccessory,
    this.trailingAccessory,
    this.bottomAccessory,
    this.padding,
    this.spacing = 5.0,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => _InSyncListItemState();
}

class _InSyncListItemState extends State<InSyncListItem> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min, // occupy vertical space as u need
      children: [
        Padding(
          padding:
              widget.padding ??
              const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                          fontWeight: widget.boldTitle ? .bold : FontWeight.w500,
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
      ],
    );
  }
}

class ListChevronAccessory extends StatelessWidget {

  const ListChevronAccessory({super.key});

  @override
  Widget build(BuildContext context) {

    return ExclusionFilter(
      child:
      const Icon(
        Icons.arrow_forward_ios,
        color: InSyncColors.prominentItemColor,
        size: 20,
      ),
    );
  }

}

List<InSyncListItem> getTickets(BuildContext context) {
  return [
    InSyncListItem(
      title: 'Fix login issue',
      onTap: () {
      },
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
          Tag(text: 'Medium Priority', backgroundColor: InSyncColors.yellow),
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
