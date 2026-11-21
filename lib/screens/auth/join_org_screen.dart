import 'package:flutter/material.dart';
import 'package:insync/screens/auth/create_org_screen.dart';
import 'package:insync/screens/auth/sign_up_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

import '../../widgets/button.dart';

/// Figma: Pages / Auth – "Join your org." (474:4805)
class JoinOrgScreen extends StatefulWidget {
  const JoinOrgScreen({super.key});

  @override
  State<JoinOrgScreen> createState() => _JoinOrgScreenState();
}

class _JoinOrgScreenState extends State<JoinOrgScreen> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _next() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SignUpScreen(organizationCode: _code.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            const AuthTitle('Join your org.'),
            const AuthSubtitle(
              'If you are already part of an organization, ask the administrators '
                  'to issue a code for you to join right away.',
            ),
            AuthTextField(
              hint: 'XXXX-XXXX-XXXX-XXXX',
              controller: _code,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => _next(),
            ),
          ],
        ),
        Column(
          spacing: 15,
          children: [
            ActionButton(label: 'Next', onPressed: _next),
            ActionButton(
              label: 'Create an org',
              style: ActionButtonStyle.secondary,
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CreateOrgScreen()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
