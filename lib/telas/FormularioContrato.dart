import 'package:flutter/material.dart';
import 'package:app01/model/ContratoLocacao.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Locatario.dart';
import 'package:app01/telas/DashboardData.dart';

class FormularioContrato extends StatefulWidget {
  const FormularioContrato({super.key});

  @override
  State<FormularioContrato> createState() => _FormularioContratoState();
}

class _FormularioContratoState extends State<FormularioContrato> {
  final _kmController = TextEditingController();

  Automovel? _veiculoSelecionado;
  Locatario? _locatarioSelecionado;

  @override
  void dispose() {
    _kmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Contrato')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seleção de Locatário via Dropdown
            DropdownButtonFormField<Locatario>(
              decoration:
                  const InputDecoration(labelText: 'Selecionar Locatário'),
              items: DashboardData.locatarios.map((loc) {
                return DropdownMenuItem(
                    value: loc, child: Text(loc.nomeCompleto));
              }).toList(),
              onChanged: (val) => setState(() => _locatarioSelecionado = val),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<Automovel>(
              decoration:
                  const InputDecoration(labelText: 'Selecionar Veículo'),
              items: DashboardData.automoveis.map((auto) {
                return DropdownMenuItem(
                    value: auto, child: Text('${auto.marca} ${auto.modelo}'));
              }).toList(),
              onChanged: (val) => setState(() => _veiculoSelecionado = val),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _kmController,
              decoration:
                  const InputDecoration(labelText: 'Quilometragem Inicial'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_veiculoSelecionado != null &&
                    _locatarioSelecionado != null) {
                  final novoContrato = ContratoLocacao(
                    id: 'C-${DateTime.now().millisecondsSinceEpoch}',
                    locatario: _locatarioSelecionado!,
                    automovel: _veiculoSelecionado!,
                    dataRetirada: DateTime.now(),
                    dataDevolucaoPrevista:
                        DateTime.now().add(const Duration(days: 7)),
                    kmInicial: double.tryParse(_kmController.text) ?? 0.0,
                  );

                  Navigator.pop(context, novoContrato);
                }
              },
              child: const Text('Gerar Contrato'),
            )
          ],
        ),
      ),
    );
  }
}
