import 'package:flutter/material.dart';
import 'package:insync/screens/auth/create_org_screen.dart';
import 'package:insync/screens/auth/login_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

import '../../widgets/button.dart';

/// Translucent pill used by both the "Text Field" and secondary
/// "Wide Prominiant Button" components.
BoxDecoration _glassPill() => BoxDecoration(
  // screen(rgba(34,34,34,0.85)) == white @ 0.85*34/255
  color: Colors.white.withValues(alpha: 0.85 * 34 / 255),
  borderRadius: BorderRadius.circular(80),
  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
  boxShadow: [
    BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 10),
  ],
);

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Column(
          spacing: 20,
          crossAxisAlignment: .start,
          children: [
            const AuthTitle('InSync'),
            const AuthSubtitle(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
                  'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
          ],
        ),
        Column(
          spacing: 15,
          children: [
            ActionButton(
              label: 'Sign up',
              size: .expanded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateOrgScreen()),
              ),
            ),
            ActionButton(
              label: 'Log in',
              size: .expanded,
              style: ActionButtonStyle.secondary,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
            ),
          ],
        )
      ],
    );
  }
}
