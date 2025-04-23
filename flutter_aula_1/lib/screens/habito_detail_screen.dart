import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HabitoDetailScreen extends StatelessWidget {
  const HabitoDetailScreen({super.key});

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final habitoId = ModalRoute.of(context)!.settings.arguments as String;
    final habito = Provider.of<HabitoProvider>(context).getHabitoById(habitoId);

    return Scaffold(
      appBar: AppBar(
        title: Text(habito.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<HabitoProvider>(
                context,
                listen: false,
              ).deleteHabito(habito.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Hábito removido')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(habito.icon, style: const TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Frequência'),
              subtitle: Text(habito.frequency),
            ),
            if (habito.reminderTime != null)
              ListTile(
                title: const Text('Lembrete'),
                subtitle: Text(habito.reminderTime!.format(context)),
              ),
            ListTile(
              title: const Text('Criado em'),
              subtitle: Text(_formatDate(habito.createdAt)),
            ),
            ListTile(
              title: const Text('Total de dias concluídos'),
              subtitle: Text('${habito.completedDates.length} dias'),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Dias concluídos:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...habito.completedDates
                .map(
                  (date) => ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(_formatDate(date)),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
