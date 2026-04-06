import 'package:app01/model/Automovel.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioVeiculo.dart';

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
              trailing: PopupMenuButton<String>(
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'editar',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Editar'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'remover',
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Remover',
                                style: TextStyle(color: Colors.red)),
                          ),
                        )
                      ]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=> const FormularioVeiculo()));
        }, child: const Icon(Icons.add)
        ),
    );
  }
}
