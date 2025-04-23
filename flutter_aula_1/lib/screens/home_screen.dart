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
    final dataFormatada = '${Utils.formatarData(hoje)}';
    final progresso = Utils.calcularProgressoHabitos(habitos);

    return Scaffold(
      appBar: null,

      body: Column(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(progresso['completos']! > 0 ? progresso['completos']! / progresso['total']! * 100 : 0).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${progresso['completos']} de ${progresso['total']} hábitos completos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const Icon(Icons.calendar_month, size: 48, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22, left: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Meus hábitos',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          habitos.isEmpty
              ? const Center(
                child: Text(
                  'Nenhum hábito cadastrado ainda.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
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
        backgroundColor: Colors.deepOrange, // Cor de fundo personalizada
        shape: RoundedRectangleBorder(
          // Forma arredondada para um visual mais moderno
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0, // Sombra suave para dar profundidade
        child: const Icon(
          Icons.add,
          color: Colors.white, // Cor do ícone
          size: 30, // Tamanho maior para maior destaque
        ),
      ),
    );
  }
}
