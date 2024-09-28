import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Contato.dart';

class Cadastro extends StatefulWidget {
  final Function(Contato) onDelete;
  final Function(Contato) onSave;
  final Contato? contato;

  Cadastro({required this.onDelete, required this.onSave, this.contato});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late String telefone;
  late String email;

  @override
  void initState() {
    super.initState();
    if (widget.contato != null) {
      nome = widget.contato!.nome;
      telefone = widget.contato!.telefone;
      email = widget.contato!.email;
    } else {
      nome = '';
      telefone = '';
      email = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Contato')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                onChanged: (value) => nome = value,
              ),
              TextFormField(
                initialValue: telefone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: '(xx) xxxxxx-xxxx'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15), 
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }if (!RegExp(r'\d{11}').hasMatch(value)) {
                    return 'Formato inválido. Ex: (XX) XXXXX-XXXX';
                  }
                  return null;
                },
                onChanged: (value) => telefone = value,
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(Contato(nome: nome, telefone: telefone, email: email));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Salvar'),
              ),
              if (widget.contato != null) ...[
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onDelete(widget.contato!);
                  Navigator.of(context).pop();
                },
                child: const Text('Remover'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
