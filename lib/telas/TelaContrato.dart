import 'package:app01/model/ContratoLocacao.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioContrato.dart';

class TelaContrato extends StatefulWidget {
  const TelaContrato({super.key});

  @override
  State<TelaContrato> createState() => _TelaContratoState();
}

class _TelaContratoState extends State<TelaContrato> {
  @override
  Widget build(BuildContext context) {
    final List<ContratoLocacao> contratos = DashboardData.contratos;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Contratos')),
      body: ListView.builder(
        itemCount: contratos.length,
        itemBuilder: (context, index) {
          final contrato = contratos[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.description),
              title: Text(
                  'Contrato: ${contrato.id} - ${contrato.automovel.modelo}'),
              subtitle: Text('Locatário: ${contrato.locatario.nomeCompleto}'),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'remover') {
                    setState(() {
                      contratos.removeAt(index);
                    });
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
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
          final ContratoLocacao? novoContrato =
              await Navigator.push<ContratoLocacao>(
            context,
            MaterialPageRoute(builder: (context) => const FormularioContrato()),
          );

          if (novoContrato != null) {
            setState(() {
              DashboardData.contratos.add(novoContrato);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
