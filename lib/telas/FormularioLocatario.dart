import 'package:flutter/material.dart';
import 'package:app01/model/Locatario.dart';

class FormularioLocatario extends StatefulWidget {
  const FormularioLocatario({super.key});

  @override
  State<FormularioLocatario> createState() => _FormularioLocatarioState();
}

class _FormularioLocatarioState extends State<FormularioLocatario> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cnhController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoController = TextEditingController();
  DateTime? _dataNascimento;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _cnhController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // 18 anos atrás
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Locatário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome Completo'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(labelText: 'CPF'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _cnhController,
                  decoration: const InputDecoration(labelText: 'Nº CNH'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return 'Campo obrigatório';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Email inválido';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(labelText: 'Endereço'),
                  validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dataNascimento == null
                            ? 'Selecione a data de nascimento'
                            : 'Data: ${_dataNascimento!.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _selecionarData(context),
                      child: const Text('Selecionar Data'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _dataNascimento != null) {
                      final novoLocatario = Locatario(
                        cpf: _cpfController.text,
                        nomeCompleto: _nomeController.text,
                        numeroCnh: _cnhController.text,
                        telefone: _telefoneController.text,
                        email: _emailController.text,
                        endereco: _enderecoController.text,
                        dataNascimento: _dataNascimento!,
                      );
                      Navigator.pop(context, novoLocatario);
                    } else if (_dataNascimento == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecione a data de nascimento')),
                      );
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
