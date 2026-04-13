import 'package:flutter/material.dart';
import 'package:app01/model/ContratoLocacao.dart';

class TelaDetalhesContrato extends StatelessWidget {
  final ContratoLocacao contrato;

  const TelaDetalhesContrato({super.key, required this.contrato});

  @override
  Widget build(BuildContext context) {
    final isEncerrado = contrato.dataDevolucaoReal != null;

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Contrato ${contrato.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${contrato.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text('Locatário: ${contrato.locatario.nomeCompleto}'),
                      Text('CPF: ${contrato.locatario.cpf}'),
                      Text('Telefone: ${contrato.locatario.telefone}'),
                      const SizedBox(height: 10),
                      Text('Veículo: ${contrato.automovel.marca} ${contrato.automovel.modelo}'),
                      Text('Placa: ${contrato.automovel.placa}'),
                      Text('Categoria: ${contrato.automovel.categoria.nome}'),
                      const SizedBox(height: 10),
                      Text('Km Inicial: ${contrato.kmInicial}'),
                      if (contrato.kmFinal != null) Text('Km Final: ${contrato.kmFinal}'),
                      const SizedBox(height: 10),
                      Text('Data de Retirada: ${contrato.dataRetirada.toLocal().toString().split(' ')[0]}'),
                      Text('Data Prevista de Devolução: ${contrato.dataDevolucaoPrevista.toLocal().toString().split(' ')[0]}'),
                      if (contrato.dataDevolucaoReal != null)
                        Text('Data Real de Devolução: ${contrato.dataDevolucaoReal!.toLocal().toString().split(' ')[0]}'),
                      const SizedBox(height: 10),
                      Text('Status: ${isEncerrado ? 'Encerrado' : 'Ativo'}', style: TextStyle(color: isEncerrado ? Colors.green : Colors.orange)),
                      if (contrato.valorTotal != null)
                        Text('Valor Total: R\$ ${contrato.valorTotal!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}