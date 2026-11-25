import 'package:flutter/material.dart';
import 'package:insync/screens/auth-screens/auth_navigation.dart';
import 'package:insync/screens/auth-screens/login_screen.dart';
import 'package:insync/services/OrgServices.dart';
import 'package:insync/services/auth_service.dart';
import 'package:insync/widgets/auth_widgets/auth_components.dart';
import 'package:insync/widgets/text_field.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:native_liquid_glass/native_liquid_glass.dart';

import '../../widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  // takes the name value coming from create org
  final String? organizationName;

  // takes the name value coming from entering org code
  final String? organizationCode;

  const SignUpScreen({super.key, this.organizationName, this.organizationCode});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _authService = AuthService();
  final _orgService = OrgService();

  bool _isLoading = false;

  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _displayNameController.addListener((){
      setState(() {});
    });

    _emailController.addListener((){
      setState(() {});
    });

    _passwordController.addListener((){
      setState(() {});
    });
  }

  //only one key for the whole form
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: Create the account with an org code
  Future<void> _signUp() async {
    if (_isLoading) return;
    //if it succeeds and valid then move to login
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
    ;

    setState(() {
      _isLoading = true;
    });

    try {
      //retrieving user input
      final name = _displayNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // widget. means the org name was passed through a constructor + it gives access to the statful widget
      if (widget.organizationName != null) {
        // creating a new organization + its admin
        await _orgService.createOrgWithAdmin(
          orgName: widget.organizationName!,
          name: name,
          email: email,
          password: password,
        );
      } else if (widget.organizationCode != null) {
        // joining an existing organization
        await _authService.registerWithCode(
          email,
          password,
          name,
          widget.organizationCode!,
        );
      }
      //if user left this screen while await, stop and don't finish running this function
      if (!mounted) return;
      //else go ahead and enter the app
      enterApp(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            spacing: 20,
            children: [
              const AuthTitle('Now, It’s time to\nsign you up.'),
              ActionTextField(
                hint: 'Display Name',
                controller: _displayNameController,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              ActionTextField(
                hint: 'myemail@provider.com',
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
                hint: 'mySUpErStrong_Password@12345',
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                onSubmit: (_) => _signUp(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)  {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Stack(
          alignment: .center,
          children: [
            ActionButton(label: !_isLoading ? 'Log in' : '', onPressed: _signUp, disabled: _isLoading || _passwordController.text.trim().isEmpty || _emailController.text.trim().isEmpty || _displayNameController.text.trim().isEmpty,),
            NativeLiquidGlassUtils.supportsLiquidGlass ? LiquidGlassActivityIndicator(animating: _isLoading,) : _isLoading ? M3ELoadingIndicator() : Container()
          ],
        )
      ],
    );
  }
}