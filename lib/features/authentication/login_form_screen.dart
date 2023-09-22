import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A Form needs a GlobalKey as a identifier so as to access to Form's State and run the method regarding the Form

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) { // validate() validates every TextFormField at once
        _formKey.currentState!.save(); // save() runs a callback function onSaved towards each text input, given that all the inputs have no error
        Navigator.of(context).pushAndRemoveUntil( // Since this Navigator is inside the State in a StatefulWidget, there is no need for _onNextTap to have a BuildContext parameter
          MaterialPageRoute(
            builder: (context) => const InterestsScreen(),
          ),
          (route) {
            print(route);
            return false; // After logged in the previous screens should not be able to access back so pushAndRemoveUntil() is used with predicate returning false
          },
        );
      }
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write your email';
                    };
                    return null;
                  },
                  onSaved: (postedValue) {
                    if (postedValue != null) {
                      formData['email'] = postedValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write your password';
                    };
                    return null;
                  },
                  onSaved: (postedValue) {
                    if (postedValue != null) {
                      formData['password'] = postedValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    text: 'Log in',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
