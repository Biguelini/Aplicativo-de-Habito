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
    Habito habito;
    try {
      habito = Provider.of<HabitoProvider>(context).getHabitoById(habitoId);
    } catch (e) {
      // Caso o hábito não seja encontrado (excluído ou não exista), navegue para a tela principal
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CircularProgressIndicator();
      });
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(habito.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<HabitoProvider>(
                context,
                listen: false,
              ).deleteHabito(habito.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Hábito removido',
                    style: TextStyle(
                      color: Color(0XFF37C871),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Color(
                    0XFFedfff4,
                  ), // cor de fundo personalizada
                  behavior:
                      SnackBarBehavior
                          .floating, // faz flutuar acima do conteúdo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // bordas arredondadas
                  ),
                  elevation: 0,
                  margin: const EdgeInsets.all(16), // margem ao redor
                  duration: const Duration(seconds: 3), // tempo de exibição
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
