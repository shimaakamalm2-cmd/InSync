import 'package:flutter/material.dart';
import 'package:insync/screens/auth/auth_navigation.dart';
import 'package:insync/screens/auth/login_screen.dart';
import 'package:insync/widgets/auth/auth_components.dart';

import '../../widgets/button.dart';

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
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // final _displayNameFormKey = GlobalKey<FormState>();
  // final _emailFormKey = GlobalKey<FormState>();
  // final _passwordFormKey = GlobalKey<FormState>();

  //only one key for the whole form 
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // TODO: Create the account (and org / join via code) once the backend exists.
  void _signUp()  {
    if(_formKey.currentState!.validate()){
      //enterApp(context);
      LoginScreen();
    }
  }

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
            AuthTextField(
              key: _formKey,
              hint: 'Display Name',
              controller: _displayNameController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              validator:(value){
                if(value==null){
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            AuthTextField(
              key: _formKey,
              hint: 'myemail@provider.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator:(value){
                if(value==null){
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            AuthTextField(
              key: _formKey,
              hint: 'mySUpErStrong_Password@12345',
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onSubmitted: (_) => _signUp(),
              validator:(value){
                if(value==null){
                  return 'Please enter a password';
                }
                if(value.length <8 ){
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
          ],
        )),
        ActionButton(label: 'Sign up', onPressed: _signUp),
      ],
    );
  }
}
