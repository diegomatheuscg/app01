import 'package:app01/model/Categoria.dart';
import 'package:app01/model/StatusAutomovel.dart';

class Automovel {
  final String placa; 
  final String marca;
  final String modelo;
  final int anoFabricacao;
  double quilometragemAtual;  final int anoModelo;
  final String cor;
  final String renavam;
  final String combustivel;

  StatusAutomovel status;
  final Categoria categoria; 

  Automovel({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.anoFabricacao,
    required this.anoModelo,
    required this.cor,
    required this.renavam,
    required this.combustivel,
    required this.quilometragemAtual,
    required this.categoria,
    this.status = StatusAutomovel.disponivel,
  });

  void atualizarStatus(StatusAutomovel novoStatus) {
    status = novoStatus;
  }

  void registrarNovaQuilometragem(double novaKm) {
    quilometragemAtual = novaKm;
  }
}