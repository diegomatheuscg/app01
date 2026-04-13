import 'package:flutter/material.dart';
import 'package:app01/model/Categoria.dart';
import 'package:app01/telas/DashboardData.dart';

class TelaCategorias extends StatefulWidget {
  const TelaCategorias({super.key});

  @override
  State<TelaCategorias> createState() => _TelaCategoriasState();
}

class _TelaCategoriasState extends State<TelaCategorias> {
  @override
  Widget build(BuildContext context) {
    final List<Categoria> categorias = DashboardData.categorias;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Categorias')),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.category, color: Colors.blue),
              title: Text(categoria.nome),
              subtitle: Text('Diária: R\$ ${categoria.valorDiaria.toStringAsFixed(2)} | Seguro: R\$ ${categoria.valorSeguro.toStringAsFixed(2)}'),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'remover') {
                    setState(() {
                      categorias.removeAt(index);
                    });
                  } else if (result == 'editar') {
                    // TODO: Implementar edição
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
          // Placeholder para formulário de categoria
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulário de Categoria em desenvolvimento')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}