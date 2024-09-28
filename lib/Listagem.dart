import 'package:flutter/material.dart';
import 'package:flutter_application_1/Contato.dart';
import 'package:flutter_application_1/Cadastro.dart';

class Listagem extends StatefulWidget {
  @override
  _ListagemState createState() => _ListagemState();
}

class _ListagemState extends State<Listagem> {
  List<Contato> contatos = [];

  void _navegacao([Contato? contato]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Cadastro(
          onDelete: _removerContato,
          onSave: _adicionarContato,
          contato: contato,
        ),
      ),
    );
  }

  void _adicionarContato(Contato contato) {
    setState(() {
      if (contatos.contains(contato)) {
        contatos[contatos.indexOf(contato)] = contato;
      } else {
        contatos.add(contato);
      }
    });
  }

  void _removerContato(Contato contato) {
    setState(() {
      contatos.remove(contato);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda de Contatos')),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contatos[index].nome),
            subtitle: Text('${contatos[index].telefone}   ${contatos[index].email}'),
            onTap: () => _navegacao(contatos[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegacao(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
