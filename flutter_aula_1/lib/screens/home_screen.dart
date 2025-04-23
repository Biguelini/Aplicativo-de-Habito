import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/utils.dart';
import 'package:flutter_aula_1/widgets/habito_title.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitoProvider = Provider.of<HabitoProvider>(context);
    final habitos = habitoProvider.habitos;
    final saudacao = Utils.saudacao();
    final hoje = DateTime.now();
    final dataFormatada = '${Utils.formatarData(hoje)}'; // Crie essa função

    return Scaffold(
      appBar: null,

      body: Column(
        children: [
          SafeArea(
            child: Container(
              width:
                  double.infinity, // Garante que ocupe toda a largura da tela
              padding: const EdgeInsets.all(16), // Ajustando o padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataFormatada, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 28, color: Colors.black),
                      children: [
                        TextSpan(text: '$saudacao, '),
                        const TextSpan(
                          text: 'Usuário!',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Verificação se há hábitos ou não
          habitos.isEmpty
              ? const Center(child: Text('Nenhum hábito cadastrado ainda.'))
              : Expanded(
                // Garantir que o ListView ocupe o espaço disponível
                child: ListView.builder(
                  itemCount: habitos.length,
                  itemBuilder: (ctx, index) {
                    final habito = habitos[index];
                    return HabitoTitle(habito: habito);
                  },
                ),
              ),
        ],
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
