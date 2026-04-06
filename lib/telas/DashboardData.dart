import '../model/Automovel.dart';
import '../model/Categoria.dart';
import '../model/ContratoLocacao.dart';
import '../model/Locatario.dart';
import '../model/StatusAutomovel.dart';

class DashboardData {
  
  static final Categoria catSUV = Categoria(id: '1', nome: 'SUV Premium', valorDiaria: 150.0, valorSeguro: 30.0);

  static final List<Automovel> automoveis = [
    Automovel(placa: 'ABC-1234', marca: 'Jeep', modelo: 'Compass', anoFabricacao: 2022, quilometragemAtual: 15000, categoria: catSUV, status: StatusAutomovel.disponivel),
    Automovel(placa: 'XYZ-9876', marca: 'Toyota', modelo: 'Corolla Cross', anoFabricacao: 2023, quilometragemAtual: 5000, categoria: catSUV, status: StatusAutomovel.alugado),
    Automovel(placa: 'DEF-5678', marca: 'VW', modelo: 'Nivus', anoFabricacao: 2021, quilometragemAtual: 35000, categoria: catSUV, status: StatusAutomovel.emManutencao),
    Automovel(placa: 'GHI-9012', marca: 'Honda', modelo: 'HR-V', anoFabricacao: 2024, quilometragemAtual: 1000, categoria: catSUV, status: StatusAutomovel.disponivel),
  ];

  static final List<Locatario> locatarios = [
    Locatario(cpf: "099.992.159-20", nomeCompleto: "Diego Matheus", numeroCnh: "123456", telefone: "44997007527"),
    Locatario(cpf: "099.992.159-20", nomeCompleto: "Diego Matheus", numeroCnh: "123456", telefone: "44997007527"),
    Locatario(cpf: "099.992.159-20", nomeCompleto: "Diego Matheus", numeroCnh: "123456", telefone: "44997007527"),
    Locatario(cpf: "099.992.159-20", nomeCompleto: "Diego Matheus", numeroCnh: "123456", telefone: "44997007527")
  ];

  static final List<ContratoLocacao> contratos = [
    ContratoLocacao(
      id: 'C-001',
      locatario: Locatario(cpf: '111', nomeCompleto: 'João', numeroCnh: '123', telefone: '999'),
      automovel: automoveis[1],
      dataRetirada: DateTime.now().subtract(const Duration(days: 5)),
      dataDevolucaoPrevista: DateTime.now(),
      kmInicial: 4500,
    )..encerrarContrato(DateTime.now(), 5000), 
  ];

  
  static int get carrosDisponiveis => automoveis.where((a) => a.status == StatusAutomovel.disponivel).length;
  
  static int get carrosAlugados => automoveis.where((a) => a.status == StatusAutomovel.alugado).length;
  
  static int get carrosManutencao => automoveis.where((a) => a.status == StatusAutomovel.emManutencao).length;

  static double get receitaEstimada {
    double total = 0;
    for (var contrato in contratos) {
      if (contrato.valorTotal != null) {
        total += contrato.valorTotal!;
      }
    }
    return total;
  }
}