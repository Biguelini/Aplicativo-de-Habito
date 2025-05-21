import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/auth_gate.dart';
import 'package:flutter_aula_1/firebase_options.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/screens/habito_detail_screen.dart';
import 'package:flutter_aula_1/screens/habito_form_screen.dart';
import 'package:flutter_aula_1/screens/home_screen.dart';
import 'package:flutter_aula_1/screens/login_screen.dart';
import 'package:flutter_aula_1/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => HabitoProvider(),
      child: MaterialApp(
        title: 'Acompanhamento de Habito',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthGate(
          child: HomeScreen(), // ou seu widget root depois do login
        ),
        routes: {
          '/add-habito': (ctx) => const HabitoFormScreen(),
          '/habito-detail': (ctx) => const HabitoDetailScreen(),
          '/login': (ctx) => const LoginScreen(),
          '/home': (ctx) => const HomeScreen(),
          '/register': (ctx) => const RegisterScreen(),
        },
      ),
    ),
  );
}
