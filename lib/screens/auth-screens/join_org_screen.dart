import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/auth-screens/create_org_screen.dart';
import 'package:insync/screens/auth-screens/sign_up_screen.dart';
import 'package:insync/widgets/auth_widgets/auth_components.dart';
import 'package:insync/widgets/common/GlassSnackBar.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

/// Figma: Pages / Auth – "Join your org." (474:4805)
class JoinOrgScreen extends StatefulWidget {
  const JoinOrgScreen({super.key});

  @override
  State<JoinOrgScreen> createState() => _JoinOrgScreenState();
}

class _JoinOrgScreenState extends State<JoinOrgScreen> {
  final _code = TextEditingController();

  @override
  void initState() {
    super.initState();

    _code.addListener(() {

      String cleanedCode = _code.text.trim().replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

      if (kDebugMode) {
        print("Cleaned Code: $cleanedCode");
      }

      _code.value = _code.value.copyWith(
        text: cleanedCode.length < 28 ? cleanedCode : cleanedCode.substring(0, 28),
        selection: _code.selection
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _next() {
    if (_code.text.length != 28) {
      ScaffoldMessenger.of(context).showSnackBar(GlassSnackBar(text: "Code must be 28 characters long", color: InSyncColors.red,));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SignUpScreen(organizationCode: _code.text.trim()),
      ));
    }
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
            ActionTextField(
              hint: 'XXXX-XXXX-XXXX-XXXX',
              controller: _code,
              textInputAction: TextInputAction.next,
              onSubmit: (_) => _next(),
              validator: (value) {
                if (value != null && value.trim().length < 28) {
                  return "Must be 28 characters long";
                } else if (value != null && value.trim().length > 28) {
                  return "Must be exactly 28 characters long";
                }
                return null;
              },
            ),
          ],
        ),
        Column(
          spacing: 15,
          children: [
            ActionButton(label: 'Next', onPressed: _next, disabled: _code.text.trim().length != 28,),
            ActionButton(
              label: 'Create an org',
              style: ActionButtonStyle.secondary,
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(Duration(milliseconds: 500), () {
                  if (!mounted) return;
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const CreateOrgScreen()),
                  );
                });
              }
            ),
          ],
        ),
      ],
    );
  }
}
