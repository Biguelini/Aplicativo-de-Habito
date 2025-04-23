import 'package:flutter/material.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:provider/provider.dart';

class HabitoFormScreen extends StatefulWidget {
  const HabitoFormScreen({super.key});

  @override
  State<HabitoFormScreen> createState() => _HabitoFormScreenState();
}

class _HabitoFormScreenState extends State<HabitoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _frequency = '';
  String _icon = '';
  TimeOfDay? _reminderTime;

  void _submitForm() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;

    _formKey.currentState!.save();

    Provider.of<HabitoProvider>(context, listen: false).addHabito(
      name: _name,
      frequency: _frequency,
      icon: _icon,
      reminderTime: _reminderTime,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Hábito salvo com sucesso!')));

    Navigator.of(context).pop();
  }

  void _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );

    if (pickedTime != null) {
      setState(() {
        _reminderTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Hábito')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Hábito'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, inisira um nome.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _frequency,
                items: const [
                  DropdownMenuItem(value: 'Diário', child: Text('Diário')),
                  DropdownMenuItem(value: 'Semanal', child: Text('Semanal')),
                ],
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Frequência'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _reminderTime == null
                          ? 'Sem horário definido'
                          : 'Horário: ${_reminderTime!.format(context)}',
                    ),
                  ),

                  TextButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time),
                    label: const Text('Escolher horário'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Hábito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
