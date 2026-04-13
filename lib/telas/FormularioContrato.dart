import 'package:flutter/material.dart';
import 'package:app01/model/ContratoLocacao.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Locatario.dart';
import 'package:app01/model/StatusAutomovel.dart';
import 'package:app01/telas/DashboardData.dart';

class FormularioContrato extends StatefulWidget {
  const FormularioContrato({super.key});

  @override
  State<FormularioContrato> createState() => _FormularioContratoState();
}

class _FormularioContratoState extends State<FormularioContrato> {
  final _formKey = GlobalKey<FormState>();
  final _kmController = TextEditingController();

  Automovel? _veiculoSelecionado;
  Locatario? _locatarioSelecionado;
  DateTime? _dataRetirada;
  DateTime? _dataDevolucaoPrevista;

  @override
  void initState() {
    super.initState();
    _dataRetirada = DateTime.now();
    _dataDevolucaoPrevista = DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _kmController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData(BuildContext context, bool isRetirada) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isRetirada ? _dataRetirada! : _dataDevolucaoPrevista!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isRetirada) {
          _dataRetirada = picked;
          if (_dataDevolucaoPrevista!.isBefore(_dataRetirada!)) {
            _dataDevolucaoPrevista = _dataRetirada!.add(const Duration(days: 1));
          }
        } else {
          _dataDevolucaoPrevista = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar apenas veículos disponíveis
    final veiculosDisponiveis = DashboardData.automoveis.where((a) => a.status == StatusAutomovel.disponivel).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Contrato')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<Locatario>(
                  decoration: const InputDecoration(labelText: 'Selecionar Locatário'),
                  items: DashboardData.locatarios.map((loc) {
                    return DropdownMenuItem(value: loc, child: Text(loc.nomeCompleto));
                  }).toList(),
                  onChanged: (val) => setState(() => _locatarioSelecionado = val),
                  validator: (value) => value == null ? 'Selecione um locatário' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Automovel>(
                  decoration: const InputDecoration(labelText: 'Selecionar Veículo Disponível'),
                  items: veiculosDisponiveis.map((auto) {
                    return DropdownMenuItem(value: auto, child: Text('${auto.marca} ${auto.modelo} (${auto.placa})'));
                  }).toList(),
                  onChanged: (val) => setState(() => _veiculoSelecionado = val),
                  validator: (value) => value == null ? 'Selecione um veículo disponível' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _kmController,
                  decoration: const InputDecoration(labelText: 'Quilometragem Inicial'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Campo obrigatório';
                    if (double.tryParse(value) == null) return 'Valor inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text('Retirada: ${_dataRetirada!.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(
                      onPressed: () => _selecionarData(context, true),
                      child: const Text('Alterar'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Devolução Prevista: ${_dataDevolucaoPrevista!.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(
                      onPressed: () => _selecionarData(context, false),
                      child: const Text('Alterar'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final novoContrato = ContratoLocacao(
                        id: 'C-${DateTime.now().millisecondsSinceEpoch}',
                        locatario: _locatarioSelecionado!,
                        automovel: _veiculoSelecionado!,
                        dataRetirada: _dataRetirada!,
                        dataDevolucaoPrevista: _dataDevolucaoPrevista!,
                        kmInicial: double.parse(_kmController.text),
                      );
                      // Atualizar status do veículo para alugado
                      _veiculoSelecionado!.atualizarStatus(StatusAutomovel.alugado);
                      Navigator.pop(context, novoContrato);
                    }
                  },
                  child: const Text('Gerar Contrato'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
