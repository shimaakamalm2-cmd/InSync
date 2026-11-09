import 'package:flutter/cupertino.dart';

class InSyncList extends StatefulWidget {

  List<InSyncListItem>? items;

  InSyncList({super.key, items});

  @override
  State<StatefulWidget> createState() => _InSyncListState();
}

class _InSyncListState extends State<InSyncList> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement
    throw UnimplementedError();
  }
}

class InSyncListItem extends StatefulWidget {

  String? title;
  String? subtext;
  Widget? leadingAccessory;
  Widget? trailingAccessory;
  Widget? bottomAccessory;

  InSyncListItem({super.key, this.title, this.subtext, this.leadingAccessory,
    this.trailingAccessory, this.bottomAccessory});

  @override
  State<StatefulWidget> createState() => _InSyncListItemState();
}

class _InSyncListItemState extends State<InSyncListItem> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(widget.title ?? "")
      ],
    );
  }

}