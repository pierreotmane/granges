import 'package:flutter/material.dart';
import 'package:granges_festival/screens/session/session_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('C\'est le bar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateSessionScreen()),
            );
          },
          child: Text('Ajouter une nouvelle session'),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
