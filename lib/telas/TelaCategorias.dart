import 'package:flutter/material.dart';
import 'package:app01/model/Categoria.dart';
import 'package:app01/dao/CategoriaDAO.dart';

class TelaCategorias extends StatefulWidget {
  const TelaCategorias({super.key});

  @override
  State<TelaCategorias> createState() => _TelaCategoriasState();
}

class _TelaCategoriasState extends State<TelaCategorias> {
  final CategoriaDAO _dao = CategoriaDAO();
  late Future<List<Categoria>> _categoriasFuture;

  @override
  void initState() {
    super.initState();
    _categoriasFuture = _dao.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Categorias')),
      body: FutureBuilder<List<Categoria>>(
        future: _categoriasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final List<Categoria> categorias = snapshot.data ?? [];

          return ListView.builder(
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
                    onSelected: (String result) async {
                      if (result == 'remover') {
                        await _dao.deletar(categoria.id);
                        if (mounted) {
                          setState(() {
                            _categoriasFuture = _dao.listar();
                          });
                        }
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulário de Categoria em desenvolvimento')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}