import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/screens/habito_detail_screen.dart';
import 'package:flutter_aula_1/screens/habito_form_screen.dart';
import 'package:flutter_aula_1/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HabitoTrackerApp());
}

class HabitoTrackerApp extends StatelessWidget {
  const HabitoTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HabitoProvider(),
      child: MaterialApp(
        title: 'Acompanhamento de Habito',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomeScreen(),
          '/add-habito': (ctx) => const HabitoFormScreen(),
          '/habito-detail': (ctx) => const HabitoDetailScreen(),
        },
      ),
    );
  }
}
