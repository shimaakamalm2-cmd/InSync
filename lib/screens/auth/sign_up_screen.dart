import 'package:flutter/material.dart';
import 'package:insync/screens/auth/auth_navigation.dart';
import 'package:insync/widgets/auth/auth_components.dart';

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
    return AuthScaffold(
      children: [
        const AuthTitle('Now, It’s time to\nsign you up.'),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'Display Name',
          controller: _displayName,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
        ),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'myemail@provider.com',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
        ),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'mySUpErStrong_Password@12345',
          controller: _password,
          obscureText: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
          onSubmitted: (_) => _signUp(),
        ),
        const SizedBox(height: 25),
        AuthButton(label: 'Sign up', onPressed: _signUp),
      ],
    );
  }
}
