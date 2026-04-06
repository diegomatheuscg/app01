import 'package:flutter/material.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Categoria.dart';

class FormularioVeiculo extends StatefulWidget {
  const FormularioVeiculo({super.key});

  @override
  State<FormularioVeiculo> createState() => _FormularioVeiculoState();
}

class _FormularioVeiculoState extends State<FormularioVeiculo> {

  final _placaCtrl = TextEditingController();
  final _marcaCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _placaCtrl, decoration: const InputDecoration(labelText: 'Placa')),
            TextField(controller: _marcaCtrl, decoration: const InputDecoration(labelText: 'Marca')),
            TextField(controller: _modeloCtrl, decoration: const InputDecoration(labelText: 'Modelo')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
                final novoCarro = Automovel(
                  placa: _placaCtrl.text,
                  marca: _marcaCtrl.text,
                  modelo: _modeloCtrl.text,
                  anoFabricacao: 2024, 
                  quilometragemAtual: 0.0,
                  categoria: Categoria(id: '1', nome: 'Básico', valorDiaria: 100, valorSeguro: 20), 
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