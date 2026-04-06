import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Locatario.dart';
import 'package:app01/model/StatusAutomovel.dart';

class ContratoLocacao {
  final String id;
  final Locatario locatario;
  final Automovel automovel;
  
  final DateTime dataRetirada;
  final DateTime dataDevolucaoPrevista;
  
  // Propriedades mutáveis que iniciam nulas
  DateTime? dataDevolucaoReal; 
  double? kmFinal; 
  double? valorTotal; 

  final double kmInicial;

  ContratoLocacao({
    required this.id,
    required this.locatario,
    required this.automovel,
    required this.dataRetirada,
    required this.dataDevolucaoPrevista,
    required this.kmInicial,
  });

  // O motor de encerramento da transação
  void encerrarContrato(DateTime dataDevolucao, double kmAtualizada) {
    dataDevolucaoReal = dataDevolucao;
    kmFinal = kmAtualizada;
    
    // Atualiza o estado do veículo atrelado ao contrato
    automovel.registrarNovaQuilometragem(kmAtualizada);
    automovel.atualizarStatus(StatusAutomovel.disponivel);
    
    _calcularValorTotal();
  }

  // Lógica interna de faturamento
  void _calcularValorTotal() {
    if (dataDevolucaoReal == null) return;

    // Calcula a diferença em dias inteiros
    int diasUso = dataDevolucaoReal!.difference(dataRetirada).inDays;
    
    // Trava de segurança: cobrança mínima de 1 diária
    if (diasUso <= 0) diasUso = 1; 

    valorTotal = diasUso * (automovel.categoria.valorDiaria + automovel.categoria.valorSeguro);
  }
}