import 'package:flutter/material.dart';
import 'package:insync/screens/auth/create_org_screen.dart';
import 'package:insync/screens/auth/sign_up_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

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
    return AuthScaffold(
      children: [
        const AuthTitle('Join your org.'),
        const SizedBox(height: 20),
        const AuthSubtitle(
          'If you are already part of an organization, ask the administrators '
          'to issue a code for you to join right away.',
        ),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'XXXX-XXXX-XXXX-XXXX',
          controller: _code,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => _next(),
        ),
        const SizedBox(height: 25),
        AuthButton(label: 'Next', onPressed: _next),
        const SizedBox(height: 15),
        AuthButton(
          label: 'Create an org',
          style: AuthButtonStyle.secondary,
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const CreateOrgScreen()),
          ),
        ),
      ],
    );
  }
}
