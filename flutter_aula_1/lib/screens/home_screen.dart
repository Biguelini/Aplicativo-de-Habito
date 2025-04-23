import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/widgets/habito_title.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitoProvider = Provider.of<HabitoProvider>(context);
    final habitos = habitoProvider.habitos;

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Hábitos')),

      body:
          habitos.isEmpty
              ? const Center(child: Text('Nenhum hábito cadastrado ainda.'))
              : ListView.builder(
                itemCount: habitos.length,
                itemBuilder: (ctx, index) {
                  final habito = habitos[index];
                  return HabitoTitle(habito: habito);
                },
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-habito');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
