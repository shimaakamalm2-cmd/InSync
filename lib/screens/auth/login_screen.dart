import 'package:flutter/material.dart';
import 'package:insync/screens/auth/auth_navigation.dart';
import 'package:insync/widgets/auth/auth_components.dart';

import '../../widgets/button.dart';

/// Figma: Pages / Auth (474:4930, keyboard open: 466:4382)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // TODO: Authenticate against the backend once it exists.
  void _logIn() => enterApp(context);

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Column(
          spacing: 20,
          children: [
            const AuthTitle('Sign back into\nyour account.'),
            Form(child: Column(
              children: [
                AuthTextField(
                  key: _emailFormKey,
                  hint: 'Email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                ),
                AuthTextField(
                  key: _passwordFormKey,
                  hint: 'Password',
                  controller: _password,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) => _logIn(),
                ),
              ],
            ))
          ],
        ),
        ActionButton(label: 'Log in', onPressed: _logIn),
      ],
    );
  }
}
