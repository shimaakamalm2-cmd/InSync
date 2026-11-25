import 'package:flutter/material.dart';
import 'package:insync/screens/start_page.dart';

/// Leaves the onboarding/auth flow and replaces the whole stack with the
/// main tabbed app.
void enterApp(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => StartPage()),
    (_) => false,
  );
}
