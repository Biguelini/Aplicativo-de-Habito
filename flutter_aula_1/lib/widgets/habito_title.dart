import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:provider/provider.dart';

class HabitoTitle extends StatelessWidget {
  final Habito habito;

  const HabitoTitle({super.key, required this.habito});

  @override
  Widget build(BuildContext context) {
    final habitoProvider = Provider.of<HabitoProvider>(context, listen: false);
    final isCompleted = habito.isCompletedToday();

    return Container(
      margin: const EdgeInsets.all(16), // A margem aplicada ao Container
      decoration: BoxDecoration(
        color: isCompleted ? Color(0XFFedfff4) : Color(0XFFfbfbfb),
        borderRadius: BorderRadius.circular(12), // Bordas arredondadas
      ),
      child: Row(
        children: [
          // Coluna para o título e subtítulo
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinha à esquerda
                children: [
                  Text(
                    habito.name,
                    style: TextStyle(
                      color:
                          isCompleted
                              ? Color(0XFF37C871)
                              : Color(0XFF2F2F2F), // Cor desejada
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Frequência: ${habito.frequency}',
                    style: TextStyle(
                      color:
                          isCompleted ? Color(0XFF37C871) : Color(0XFF2F2F2F),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botão de check/uncheck
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(
                isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: isCompleted ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                if (isCompleted) {
                  habitoProvider.undoHabito(habito.id);
                } else {
                  habitoProvider.completeHabito(habito.id);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
