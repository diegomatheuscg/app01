import 'package:app01/model/Locatario.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioLocatario.dart';

class TelaLocatario extends StatefulWidget {
  const TelaLocatario({super.key});

  @override
  State<TelaLocatario> createState() => _TelaLocatarioState();
}

class _TelaLocatarioState extends State<TelaLocatario> {
  @override
  Widget build(BuildContext context) {
    final List<Locatario> locatarios = DashboardData.locatarios;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Locatários')),
      body: ListView.builder(
        itemCount: locatarios.length,
        itemBuilder: (context, index) {
          final locatario = locatarios[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(locatario.nomeCompleto),
              subtitle:
                  Text('CPF: ${locatario.cpf} | CNH: ${locatario.numeroCnh}'),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'remover') {
                    setState(() {
                      locatarios.removeAt(index);
                    });
                  } else if (result == 'editar') {
                    //AINDA NAO
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'editar',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 12),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'remover',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 12),
                        Text('Remover', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Locatario? novoLocatario = await Navigator.push<Locatario>(
            context,
            MaterialPageRoute(
                builder: (context) => const FormularioLocatario()),
          );

          if (novoLocatario != null) {
            setState(() {
              DashboardData.locatarios.add(novoLocatario);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
