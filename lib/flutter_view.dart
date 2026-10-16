import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SampleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text("Hello!", style: TextStyle(fontSize: 24, fontWeight: .bold),),
    );
  }
}

class TheSupposedlyNativeView extends StatelessWidget {

  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

}