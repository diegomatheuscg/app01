import '../model/Automovel.dart';
import '../model/Categoria.dart';
import '../model/ContratoLocacao.dart';
import '../model/Locatario.dart';
import '../model/StatusAutomovel.dart';

class DashboardData {
  static final List<Categoria> categorias = [
    Categoria(id: '1', nome: 'SUV Premium', valorDiaria: 150.0, valorSeguro: 30.0),
    Categoria(id: '2', nome: 'Sedan Executivo', valorDiaria: 120.0, valorSeguro: 25.0),
    Categoria(id: '3', nome: 'Hatch Compacto', valorDiaria: 80.0, valorSeguro: 15.0),
  ];

  static final List<Automovel> automoveis = [
    Automovel(
      placa: 'ABC-1234',
      marca: 'Jeep',
      modelo: 'Compass',
      anoFabricacao: 2022,
      anoModelo: 2022,
      cor: 'Preto',
      renavam: '123456789',
      combustivel: 'Gasolina',
      quilometragemAtual: 15000.0,
      categoria: categorias[0],
      status: StatusAutomovel.disponivel,
    ),
    Automovel(
      placa: 'XYZ-9876',
      marca: 'Toyota',
      modelo: 'Corolla Cross',
      anoFabricacao: 2023,
      anoModelo: 2023,
      cor: 'Branco',
      renavam: '987654321',
      combustivel: 'Flex',
      quilometragemAtual: 5000.0,
      categoria: categorias[0],
      status: StatusAutomovel.alugado,
    ),
    Automovel(
      placa: 'DEF-5678',
      marca: 'VW',
      modelo: 'Nivus',
      anoFabricacao: 2021,
      anoModelo: 2021,
      cor: 'Prata',
      renavam: '456789123',
      combustivel: 'Gasolina',
      quilometragemAtual: 35000.0,
      categoria: categorias[1],
      status: StatusAutomovel.emManutencao,
    ),
    Automovel(
      placa: 'GHI-9012',
      marca: 'Honda',
      modelo: 'HR-V',
      anoFabricacao: 2024,
      anoModelo: 2024,
      cor: 'Azul',
      renavam: '789123456',
      combustivel: 'Flex',
      quilometragemAtual: 1000.0,
      categoria: categorias[1],
      status: StatusAutomovel.disponivel,
    ),
  ];

  static final List<Locatario> locatarios = [
    Locatario(
      cpf: '099.992.159-20',
      nomeCompleto: 'Diego Matheus',
      numeroCnh: '123456789',
      telefone: '44997007527',
      email: 'diego@example.com',
      endereco: 'Rua Exemplo, 123',
      dataNascimento: DateTime(1990, 5, 15),
    ),
    Locatario(
      cpf: '123.456.789-00',
      nomeCompleto: 'João Silva',
      numeroCnh: '987654321',
      telefone: '11987654321',
      email: 'joao@example.com',
      endereco: 'Av. Central, 456',
      dataNascimento: DateTime(1985, 10, 20),
    ),
    Locatario(
      cpf: '456.789.123-11',
      nomeCompleto: 'Maria Oliveira',
      numeroCnh: '456789123',
      telefone: '21876543210',
      email: 'maria@example.com',
      endereco: 'Praça da Cidade, 789',
      dataNascimento: DateTime(1992, 3, 10),
    ),
    Locatario(
      cpf: '789.123.456-22',
      nomeCompleto: 'Pedro Santos',
      numeroCnh: '321654987',
      telefone: '31987654321',
      email: 'pedro@example.com',
      endereco: 'Estrada Velha, 101',
      dataNascimento: DateTime(1988, 7, 5),
    ),
  ];

  static final List<ContratoLocacao> contratos = [
    ContratoLocacao(
      id: 'C-001',
      locatario: locatarios[1],
      automovel: automoveis[1],
      dataRetirada: DateTime.now().subtract(const Duration(days: 5)),
      dataDevolucaoPrevista: DateTime.now(),
      kmInicial: 4500.0,
    )..encerrarContrato(DateTime.now(), 5000.0),
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