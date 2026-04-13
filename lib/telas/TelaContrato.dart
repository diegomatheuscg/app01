import 'package:app01/model/ContratoLocacao.dart';
import 'package:app01/telas/DashboardData.dart';
import 'package:flutter/material.dart';
import 'FormularioContrato.dart';
import 'TelaDetalhesContrato.dart';

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
          final isEncerrado = contrato.dataDevolucaoReal != null;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                isEncerrado ? Icons.check_circle : Icons.pending,
                color: isEncerrado ? Colors.green : Colors.orange,
              ),
              title: Text('Contrato: ${contrato.id}'),
              subtitle: Text(
                'Veículo: ${contrato.automovel.modelo} | Locatário: ${contrato.locatario.nomeCompleto}\n'
                'Retirada: ${contrato.dataRetirada.toLocal().toString().split(' ')[0]} | '
                'Devolução Prevista: ${contrato.dataDevolucaoPrevista.toLocal().toString().split(' ')[0]}\n'
                '${isEncerrado ? 'Valor Total: R\$ ${contrato.valorTotal?.toStringAsFixed(2)}' : 'Status: Ativo'}',
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDetalhesContrato(contrato: contrato)));
              },
              trailing: isEncerrado
                  ? null
                  : PopupMenuButton<String>(
                      onSelected: (String result) {
                        if (result == 'encerrar') {
                          _encerrarContrato(context, contrato);
                        } else if (result == 'remover') {
                          setState(() {
                            contratos.removeAt(index);
                          });
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'encerrar',
                          child: Row(
                            children: [
                              Icon(Icons.stop),
                              SizedBox(width: 12),
                              Text('Encerrar Contrato'),
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
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ContratoLocacao? novoContrato = await Navigator.push<ContratoLocacao>(
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

  void _encerrarContrato(BuildContext context, ContratoLocacao contrato) {
    final dataController = TextEditingController(text: DateTime.now().toLocal().toString().split(' ')[0]);
    final kmController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Encerrar Contrato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dataController,
              decoration: const InputDecoration(labelText: 'Data de Devolução (YYYY-MM-DD)'),
            ),
            TextField(
              controller: kmController,
              decoration: const InputDecoration(labelText: 'Quilometragem Final'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final data = DateTime.tryParse(dataController.text);
              final km = double.tryParse(kmController.text);
              if (data != null && km != null) {
                setState(() {
                  contrato.encerrarContrato(data, km);
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dados inválidos')));
              }
            },
            child: const Text('Encerrar'),
          ),
        ],
      ),
    );
  }
}
