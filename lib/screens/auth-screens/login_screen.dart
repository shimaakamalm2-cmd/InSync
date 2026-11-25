import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insync/colors.dart';
import 'package:insync/screens/auth-screens/auth_navigation.dart';
import 'package:insync/services/auth_service.dart';
import 'package:insync/widgets/auth_widgets/auth_components.dart';
import 'package:insync/widgets/common/GlassSnackBar.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();
  bool _isLoading = false;

  //only one key for the whole form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {});
    });

    _passwordController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _logIn() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      enterApp(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ;
      ScaffoldMessenger.of(context)
          .showSnackBar(GlassSnackBar(text: e.code, color: InSyncColors.red));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(GlassSnackBar(text: e.toString(), color: InSyncColors.red));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
            const AuthTitle('Sign back into\nyour account.'),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 20,
                children: [
                  ActionTextField(
                    hint: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  ActionTextField(
                    hint: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSubmit: (_) => _logIn(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Stack(
          alignment: .center,
          children: [
            ActionButton(label: !_isLoading ? 'Log in' : '', onPressed: _logIn, disabled: _isLoading || _passwordController.text.trim().isEmpty || _emailController.text.trim().isEmpty,),
            NativeLiquidGlassUtils.supportsLiquidGlass ? LiquidGlassActivityIndicator(animating: _isLoading,) : _isLoading ? M3ELoadingIndicator() : Container()
          ],
        )
      ],
    );
  }
}
