import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:flutter_aula_1/providers/habito_provider.dart';
import 'package:provider/provider.dart';

class EditHabitoScreen extends StatefulWidget {
  final Habito habito;

  const EditHabitoScreen({super.key, required this.habito});

  @override
  _EditHabitoScreenState createState() => _EditHabitoScreenState();
}

class _EditHabitoScreenState extends State<EditHabitoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _frequency;
  late TimeOfDay? _reminderTime;

  @override
  void initState() {
    super.initState();
    _name = widget.habito.name;
    _frequency = widget.habito.frequency;
    _reminderTime = widget.habito.reminderTime;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<HabitoProvider>(context, listen: false).editHabito(
        widget.habito.id,
        name: _name,
        frequency: _frequency,
        remindertime: _reminderTime,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Alterações salvas com sucesso!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      Navigator.of(context).pop();
    }
  }

  void _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
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
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Editar Hábito", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Nome do Hábito',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Frequência',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                ),
                value: _frequency,
                items:
                    ['Diario', 'Semanal']
                        .map(
                          (option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma frequência.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _reminderTime == null
                          ? 'Sem horário definido'
                          : 'Horário: ${_reminderTime!.format(context)}',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(
                      Icons.access_time,
                      color: Colors.deepOrange,
                    ),
                    label: const Text(
                      'Escolher horário',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save),
                label: const Text('Salvar alterações'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
