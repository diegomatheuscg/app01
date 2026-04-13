import 'package:flutter/material.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Categoria.dart';
import 'package:app01/model/StatusAutomovel.dart';
import 'package:app01/telas/DashboardData.dart';

class FormularioVeiculo extends StatefulWidget {
  const FormularioVeiculo({super.key});

  @override
  State<FormularioVeiculo> createState() => _FormularioVeiculoState();
}

class _FormularioVeiculoState extends State<FormularioVeiculo> {
  final _formKey = GlobalKey<FormState>();
  final _placaController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoFabricacaoController = TextEditingController();
  final _anoModeloController = TextEditingController();
  final _corController = TextEditingController();
  final _renavamController = TextEditingController();
  final _combustivelController = TextEditingController();
  final _quilometragemController = TextEditingController();

  Categoria? _categoriaSelecionada;
  StatusAutomovel? _statusSelecionado;

  @override
  void initState() {
    super.initState();
    _categoriaSelecionada = DashboardData.categorias.first;
    _statusSelecionado = StatusAutomovel.disponivel;
  }

  @override
  void dispose() {
    _placaController.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _anoFabricacaoController.dispose();
    _anoModeloController.dispose();
    _corController.dispose();
    _renavamController.dispose();
    _combustivelController.dispose();
    _quilometragemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _placaController,
                  decoration: const InputDecoration(labelText: 'Placa'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _marcaController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _anoFabricacaoController,
                  decoration: const InputDecoration(labelText: 'Ano de Fabricação'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _anoModeloController,
                  decoration: const InputDecoration(labelText: 'Ano do Modelo'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _corController,
                  decoration: const InputDecoration(labelText: 'Cor'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _renavamController,
                  decoration: const InputDecoration(labelText: 'RENAVAM'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _combustivelController,
                  decoration: const InputDecoration(labelText: 'Combustível'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _quilometragemController,
                  decoration: const InputDecoration(labelText: 'Quilometragem Atual'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                DropdownButtonFormField<Categoria>(
                  initialValue: _categoriaSelecionada,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  items: DashboardData.categorias.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat.nome));
                  }).toList(),
                  onChanged: (val) => setState(() => _categoriaSelecionada = val),
                  validator: (value) => value == null ? 'Selecione uma categoria' : null,
                ),
                DropdownButtonFormField<StatusAutomovel>(
                  initialValue: _statusSelecionado,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: StatusAutomovel.values.map((status) {
                    return DropdownMenuItem(value: status, child: Text(status.name));
                  }).toList(),
                  onChanged: (val) => setState(() => _statusSelecionado = val),
                  validator: (value) => value == null ? 'Selecione um status' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final novoCarro = Automovel(
                        placa: _placaController.text,
                        marca: _marcaController.text,
                        modelo: _modeloController.text,
                        anoFabricacao: int.parse(_anoFabricacaoController.text),
                        anoModelo: int.parse(_anoModeloController.text),
                        cor: _corController.text,
                        renavam: _renavamController.text,
                        combustivel: _combustivelController.text,
                        quilometragemAtual: double.parse(_quilometragemController.text),
                        categoria: _categoriaSelecionada!,
                        status: _statusSelecionado!,
                      );
                      Navigator.pop(context, novoCarro);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}