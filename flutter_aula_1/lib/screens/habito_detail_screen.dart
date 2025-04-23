import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:flutter_aula_1/screens/habito_edit_screen.dart';
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
    Habito habito;
    try {
      habito = Provider.of<HabitoProvider>(context).getHabitoById(habitoId);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CircularProgressIndicator();
      });
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(habito.name, style: TextStyle(color: Colors.deepOrange)),
        iconTheme: IconThemeData(color: Colors.deepOrange),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.deepOrange),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<HabitoProvider>(
                context,
                listen: false,
              ).deleteHabito(habito.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Hábito removido com sucesso!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.deepOrange),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditHabitoScreen(habito: habito),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
                    leading: const Icon(Icons.check_box, color: Colors.green),
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
