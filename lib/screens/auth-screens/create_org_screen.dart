import 'package:flutter/material.dart';
import 'package:insync/screens/auth-screens/join_org_screen.dart';
import 'package:insync/screens/auth-screens/sign_up_screen.dart';
import 'package:insync/widgets/auth_widgets/auth_components.dart';
import 'package:insync/widgets/common/GlassSnackBar.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';


class CreateOrgScreen extends StatefulWidget {
  const CreateOrgScreen({super.key});

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  final _orgName = TextEditingController();

//to dispose the controller resources
  @override
  void dispose() {
    _orgName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _orgName.addListener(() {
      setState(() {});
    });
  }

  void _next() {
    final orgName = _orgName.text.trim();

    if (orgName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        GlassSnackBar(text: "Please enter your organization name.")
      );
      return;
    }
//  pushing the orgname to the next page for to create the org object
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SignUpScreen(
          organizationName: orgName,//maps the org name entered to the constructure in signup
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            const AuthTitle('Let us get to\nknow you.'),
            const AuthSubtitle(
              'What should we call your organization?\n'
                  'Alternatively, you can enter an organization code instead.',
            ),
            ActionTextField(
              hint: 'My InSync Organization',
              controller: _orgName,
              textInputAction: TextInputAction.next,
              onSubmit: (_) => _next(),
            ),
          ],
        ),
        Column(
          spacing: 15,
          children: [
            ActionButton(disabled: _orgName.text.trim().isEmpty, label: 'Next', onPressed: _next),
            ActionButton(
              label: 'Join an org',
              style: ActionButtonStyle.secondary,
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const JoinOrgScreen()),
              ),
            ),
          ],
        )
      ],
    );
  }
}