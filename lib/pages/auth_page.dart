import 'package:chat/components/auth_form.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    setState(() => isLoading = true);
    print(formData.email);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            child: AuthForm(
              onSubmit: _handleSubmit,
            ),
          ),
        ),
        if (isLoading)
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}