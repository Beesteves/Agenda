import 'package:flutter/material.dart';
import 'package:flutter_application_1/ContactListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ContactListScreen(),
    );
  }
}