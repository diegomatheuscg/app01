import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Locatario.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';

class TelaLocatario extends StatelessWidget {
  const TelaLocatario({super.key});
  @override
  Widget build(BuildContext context) {
    List<Locatario> locatarios = DashboardData.locatarios;
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Automóveis')),
      body: ListView.builder(
        itemCount: locatarios.length,
        itemBuilder: (context, index) {
          final locatario = locatarios[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${locatario.nomeCompleto}'),
              subtitle: Text('CPF: ${locatario.cpf}'),
              trailing: Text('CNH: ${locatario.numeroCnh}'),
            ),
          );
        },
      ),
    );
  }
}
