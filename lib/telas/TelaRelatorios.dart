import 'package:flutter/material.dart';
import 'package:app01/telas/DashboardData.dart';

class TelaRelatorios extends StatelessWidget {
  const TelaRelatorios({super.key});

  @override
  Widget build(BuildContext context) {
    final contratosAtivos = DashboardData.contratos.where((c) => c.dataDevolucaoReal == null).length;
    final receitaTotal = DashboardData.receitaEstimada;
    final veiculosDisponiveis = DashboardData.carrosDisponiveis;
    final veiculosAlugados = DashboardData.carrosAlugados;
    final veiculosManutencao = DashboardData.carrosManutencao;

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios e Estatísticas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visão Geral',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildCardRelatorio('Contratos Ativos', contratosAtivos.toString(), Icons.assignment, Colors.orange),
                _buildCardRelatorio('Receita Total', 'R\$ ${receitaTotal.toStringAsFixed(2)}', Icons.monetization_on, Colors.green),
                _buildCardRelatorio('Veículos Disponíveis', veiculosDisponiveis.toString(), Icons.check_circle, Colors.blue),
                _buildCardRelatorio('Veículos Alugados', veiculosAlugados.toString(), Icons.key, Colors.purple),
                _buildCardRelatorio('Em Manutenção', veiculosManutencao.toString(), Icons.warning, Colors.amber),
                _buildCardRelatorio('Total de Veículos', DashboardData.automoveis.length.toString(), Icons.directions_car, Colors.teal),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Contratos Recentes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DashboardData.contratos.length,
              itemBuilder: (context, index) {
                final contrato = DashboardData.contratos[index];
                return Card(
                  child: ListTile(
                    title: Text('Contrato ${contrato.id}'),
                    subtitle: Text('Locatário: ${contrato.locatario.nomeCompleto} | Valor: R\$ ${contrato.valorTotal?.toStringAsFixed(2) ?? 'Pendente'}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRelatorio(String label, String valor, IconData icone, Color cor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: cor, size: 32),
            const SizedBox(height: 8),
            Text(
              valor,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}