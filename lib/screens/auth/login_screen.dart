import 'package:flutter/material.dart';
import 'package:insync/screens/auth/auth_navigation.dart';
import 'package:insync/widgets/auth/auth_components.dart';

/// Figma: Pages / Auth (474:4930, keyboard open: 466:4382)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
    return AuthScaffold(
      children: [
        const AuthTitle('Sign back into\nyour account.'),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'Email',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
        ),
        const SizedBox(height: 20),
        AuthTextField(
          hint: 'Password',
          controller: _password,
          obscureText: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onSubmitted: (_) => _logIn(),
        ),
        const SizedBox(height: 25),
        AuthButton(label: 'Log in', onPressed: _logIn),
      ],
    );
  }
}
