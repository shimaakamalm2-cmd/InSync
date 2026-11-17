import 'package:flutter/material.dart';
import 'package:insync/screens/auth/join_org_screen.dart';
import 'package:insync/screens/auth/sign_up_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

/// Figma: Pages / Create an org (458:2894, keyboard open: 462:4152)
class CreateOrgScreen extends StatefulWidget {
  const CreateOrgScreen({super.key});

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  final _orgName = TextEditingController();

  @override
  void dispose() {
    _orgName.dispose();
    super.dispose();
  }

  void _next() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SignUpScreen(organizationName: _orgName.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      logoOverlap: 80,
      panelOpacity: 0.85,
      children: [
        const AuthTitle('Let us get to\nknow you.'),
        const SizedBox(height: 20),
        const AuthSubtitle(
          'What should we call your organization?\n'
          'Alternatively, you can enter an organization code instead.',
        ),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'My InSync Organization',
          controller: _orgName,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => _next(),
        ),
        const SizedBox(height: 25),
        AuthButton(label: 'Next', onPressed: _next),
        const SizedBox(height: 15),
        AuthButton(
          label: 'Join an org',
          style: AuthButtonStyle.secondary,
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const JoinOrgScreen()),
          ),
        ),
      ],
    );
  }
}
