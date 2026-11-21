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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // final _emailFormKey = GlobalKey<FormState>();
  // final _passwordFormKey = GlobalKey<FormState>();

  //only one key for the whole form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: Authenticate against the backend once it exists.
  void _logIn() {
    //if(_formKey.currentState!.validate()){
      enterApp(context);
    //}
  }
  

  @override
  Widget build(BuildContext context) {
    return OnboardingSkeleton(
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            const AuthTitle('Sign back into\nyour account.'),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 20,
                children: [
                  AuthTextField(
                    hint: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  AuthTextField(
                    hint: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSubmitted: (_) => _logIn(),
                  ),
                ],
              ),
            ),
          ],
        ),
        ActionButton(label: 'Log in', onPressed: _logIn),
      ],
    );
  }
}
