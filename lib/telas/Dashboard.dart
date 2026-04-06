import 'package:app01/telas/DashboardData.dart';
import 'package:app01/telas/TelaAutomoveis.dart';
import 'package:app01/telas/TelaLocatario.dart';
import 'package:flutter/material.dart';

class TelaDashboard extends StatelessWidget {
  const TelaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locadora Pro')),
      //DRAWER PRA NAVEGAR ENTRE AS TELAS
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'Gestão de Frotas v1.0',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.minor_crash),
              title: const Text('Automóveis'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaAutomoveis()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Clientes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaLocatario()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Locações (Contratos)'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações / Categorias'),
              onTap: () {},
            ),
          ],
        ),
      ),

      //PARA PODER SCROLLAR
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Visão Geral',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            //GRID COM OS 4 CARDS
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildCardInfo(
                  'Disponíveis',
                  DashboardData.carrosDisponiveis.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildCardInfo(
                  'Alugados',
                  DashboardData.carrosAlugados.toString(),
                  Icons.key,
                  Colors.blue,
                ),
                _buildCardInfo(
                  'Manutenção',
                  DashboardData.carrosManutencao.toString(),
                  Icons.warning,
                  Colors.amber,
                ),
                _buildCardInfo(
                  'Receita Estimada',
                  DashboardData.receitaEstimada.toString(),
                  Icons.monetization_on,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //CARDS DASHBOARD
  Widget _buildCardInfo(String label, String valor, IconData icone, Color cor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: cor, size: 30),
            const SizedBox(height: 8),
            Text(
              valor,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
