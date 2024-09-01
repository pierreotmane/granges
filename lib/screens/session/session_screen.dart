import 'package:flutter/material.dart';
import 'package:granges_festival/models/session_model.dart';
import 'package:intl/intl.dart';

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  _CreateSessionScreenState createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _initialAmountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy');

  void _submitSession() {
    if (_formKey.currentState!.validate()) {
      final newSession = Session(
        title: _titleController.text,
        date: _selectedDate,
        initialAmount: double.parse(_initialAmountController.text),
      );

      // Ici, vous pouvez sauvegarder la session dans une base de données locale, ou l'envoyer à un serveur.

      Navigator.pop(context, newSession);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Session Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a session title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _initialAmountController,
                decoration: const InputDecoration(labelText: 'Initial Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an initial amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Text("Date: ${formatter.format(_selectedDate.toLocal())}"
                      .split('dd/MM/yyyy')[0]),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select date'),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitSession,
                child: Text('Create Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
