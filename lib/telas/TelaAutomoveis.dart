import 'package:app01/model/Automovel.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';

class TelaAutomoveis extends StatelessWidget {
  const TelaAutomoveis({super.key});
  @override
  Widget build(BuildContext context) {
    List<Automovel> carros = DashboardData.automoveis;
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Automóveis')),
      body: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          final carro = carros[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${carro.marca} ${carro.modelo}'),
              subtitle: Text('Placa: ${carro.placa}'),
              trailing: Text(carro.status.name.toUpperCase()),
            ),
          );
        },
      ),
    );
  }
}
