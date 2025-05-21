import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/screens/login_screen.dart';
import 'package:flutter_aula_1/screens/register_screen.dart';

class AuthGate extends StatefulWidget {
  final Widget child;
  const AuthGate({super.key, required this.child});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _showLogin = true;

  void toggleForm() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          // Se não estiver logado, mostra Login ou Register
          if (_showLogin) {
            return LoginScreen(onSwitchToRegister: toggleForm);
          } else {
            return RegisterScreen(onSwitchToLogin: toggleForm);
          }
        }

        // Se estiver logado, mostra o app
        return widget.child;
      },
    );
  }
}
