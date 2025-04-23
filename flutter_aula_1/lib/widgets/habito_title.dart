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

    return ListTile(
      leading: Text(habito.icon, style: const TextStyle(fontSize: 24)),
      title: Text(habito.name),
      subtitle: Text('Frequência: ${habito.frequency}'),
      trailing: IconButton(
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
      onTap: () {
        Navigator.of(context).pushNamed('/habito-detail', arguments: habito.id);
      },
    );
  }
}
