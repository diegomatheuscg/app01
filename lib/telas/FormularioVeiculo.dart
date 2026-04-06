import 'package:flutter/material.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/telas/DashboardData.dart';

class FormularioVeiculo extends StatefulWidget {
  const FormularioVeiculo({super.key});

  @override
  State<FormularioVeiculo> createState() => _FormularioVeiculoState();
}

class _FormularioVeiculoState extends State<FormularioVeiculo> {
  final _placaController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();

//LIMPAR DA MEMÓRIA😍
  @override
  void dispose() {
    _placaController.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _placaController,
                decoration: const InputDecoration(labelText: 'Placa')),
            TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca')),
            TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final novoCarro = Automovel(
                  placa: _placaController.text,
                  marca: _marcaController.text,
                  modelo: _modeloController.text,
                  anoFabricacao: 2024,
                  quilometragemAtual: 0.0,
                  categoria: DashboardData.catSUV,
                );

                Navigator.pop(context, novoCarro);
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
