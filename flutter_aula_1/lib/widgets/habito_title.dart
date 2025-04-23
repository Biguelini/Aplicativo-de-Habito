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
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0XFFedfff4) : const Color(0XFFfbfbfb),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        title: Text(
          habito.name,
          style: TextStyle(
            color:
                isCompleted ? const Color(0XFF37C871) : const Color(0XFF2F2F2F),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            isCompleted
                ? Icons.check_box
                : Icons.check_box_outline_blank_outlined,
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
          Navigator.of(
            context,
          ).pushNamed('/habito-detail', arguments: habito.id);
        },
      ),
    );
  }
}
