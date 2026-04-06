import 'package:app01/model/Automovel.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioVeiculo.dart';

class TelaAutomoveis extends StatefulWidget {
  const TelaAutomoveis({super.key});

  @override
  State<TelaAutomoveis> createState() => _TelaAutomoveisState();
}

class _TelaAutomoveisState extends State<TelaAutomoveis> {
  @override
  Widget build(BuildContext context) {
    final List<Automovel> carros = DashboardData.automoveis;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Automóveis')),
      body: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          final carro = carros[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${carro.marca} ${carro.modelo}'),
              subtitle: Text('Placa: ${carro.placa}'),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'remover') {
                    setState(() {
                      carros.removeAt(index);
                    });
                  } else if (result == 'editar') {
                    //AINDA NADA
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
          final Automovel? novoCarro = await Navigator.push<Automovel>(
            context,
            MaterialPageRoute(builder: (context) => const FormularioVeiculo()),
          );

          if (novoCarro != null) {
            setState(() {
              DashboardData.automoveis.add(novoCarro);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
