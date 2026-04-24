import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_project/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (_) => DemoController(),
      child: Scaffold(
        body: SafeArea(child: Column(children: [LoginForm()])),
      ),
    );
  }
}
