import 'package:flutter/material.dart';
import 'package:insync/screens/auth/auth_navigation.dart';
import 'package:insync/widgets/auth/auth_components.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

/// Figma: Pages / Auth – "Now, It's time to sign you up." (466:4259)
class SignUpScreen extends StatefulWidget {
  /// Set when coming from "Create an org".
  final String? organizationName;

  /// Set when coming from "Join your org".
  final String? organizationCode;

  const SignUpScreen({super.key, this.organizationName, this.organizationCode});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _displayName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _displayNameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _displayName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // TODO: Create the account (and org / join via code) once the backend exists.
  void _signUp() => enterApp(context);

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Form(child:
        Column(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            const AuthTitle('Now, It’s time to\nsign you up.'),
            ActionTextField(
              key: _displayNameFormKey,
              hint: 'Display Name',
              controller: _displayName,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
            ),
            ActionTextField(
              key: _emailFormKey,
              hint: 'myemail@provider.com',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
            ),
            ActionTextField(
              key: _passwordFormKey,
              hint: 'mySUpErStrong_Password@12345',
              controller: _password,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onSubmitted: (_) => _signUp(),
            ),
          ],
        )),
        ActionButton(label: 'Sign up', onPressed: _signUp),
      ],
    );
  }
}
