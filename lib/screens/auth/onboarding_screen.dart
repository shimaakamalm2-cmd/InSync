import 'package:flutter/material.dart';
import 'package:insync/screens/auth/create_org_screen.dart';
import 'package:insync/screens/auth/login_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

/// Figma: Pages / Onboarding (444:5177)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      logoOverlap: 22,
      panelOpacity: 0.85,
      children: [
        const AuthTitle('InSync'),
        const SizedBox(height: 20),
        const AuthSubtitle(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        const SizedBox(height: 25),
        AuthButton(
          label: 'Sign up',
          height: 60,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateOrgScreen()),
          ),
        ),
        const SizedBox(height: 15),
        AuthButton(
          label: 'Log in',
          height: 60,
          style: AuthButtonStyle.secondary,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
        ),
      ],
    );
  }
}
