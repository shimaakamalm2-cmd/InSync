import 'package:flutter/material.dart';
import 'package:insync/screens/auth-screens/create_org_screen.dart';
import 'package:insync/screens/auth-screens/login_screen.dart';
import 'package:insync/widgets/auth_widgets/auth_components.dart';

import '../../widgets/button.dart';

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
