import 'package:flutter/material.dart';
import 'package:app01/model/Locatario.dart';

class FormularioLocatario extends StatefulWidget {
  const FormularioLocatario({super.key});

  @override
  State<FormularioLocatario> createState() => _FormularioLocatarioState();
}

class _FormularioLocatarioState extends State<FormularioLocatario> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cnhController = TextEditingController();
  final _telefoneController = TextEditingController();

  // Liberação dos ponteiros do buffer de texto
  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _cnhController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Locatário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome Completo')),
            TextField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number),
            TextField(
                controller: _cnhController,
                decoration: const InputDecoration(labelText: 'Nº CNH'),
                keyboardType: TextInputType.number),
            TextField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final novoLocatario = Locatario(
                  nomeCompleto: _nomeController.text,
                  cpf: _cpfController.text,
                  numeroCnh: _cnhController.text,
                  telefone: _telefoneController.text,
                );

                Navigator.pop(context, novoLocatario);
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
