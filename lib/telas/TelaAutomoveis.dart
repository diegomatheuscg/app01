import 'package:app01/model/Automovel.dart';
import 'package:app01/model/StatusAutomovel.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioVeiculo.dart';

class TelaAutomoveis extends StatefulWidget {
  const TelaAutomoveis({super.key});

  @override
  State<TelaAutomoveis> createState() => _TelaAutomoveisState();
}

class _TelaAutomoveisState extends State<TelaAutomoveis> {
  StatusAutomovel? _filtroStatus;

  @override
  Widget build(BuildContext context) {
    List<Automovel> carros = DashboardData.automoveis;
    if (_filtroStatus != null) {
      carros = carros.where((c) => c.status == _filtroStatus).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Automóveis'),
        actions: [
          DropdownButton<StatusAutomovel?>(
            value: _filtroStatus,
            hint: const Text('Filtrar'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Todos')),
              ...StatusAutomovel.values.map((status) => DropdownMenuItem(value: status, child: Text(status.name))),
            ],
            onChanged: (val) => setState(() => _filtroStatus = val),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          final carro = carros[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.blue),
              title: Text('${carro.marca} ${carro.modelo}'),
              subtitle: Text('Placa: ${carro.placa} | Status: ${carro.status.name} | Km: ${carro.quilometragemAtual}'),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'remover') {
                    setState(() {
                      DashboardData.automoveis.remove(carro);
                    });
                  } else if (result == 'editar') {

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edição em desenvolvimento')));
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
