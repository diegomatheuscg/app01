class Categoria {
  final String id;
  final String nome; // Ex: "SUV Premium"
  final double valorDiaria;
  final double valorSeguro;

  Categoria({required this.id,
    required this.nome,
    required this.valorDiaria,
    required this.valorSeguro,
  });

  double calcularCustoTotal(int dias, {bool incluirSeguro = true}) {
    double total = valorDiaria * dias;
    if (incluirSeguro) {
      total += (valorSeguro * dias);
    }
    return total;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valorDiaria': valorDiaria,
      'valorSeguro': valorSeguro,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      valorDiaria: (map['valorDiaria'] ?? 0.0).toDouble(),
      valorSeguro: (map['valorSeguro'] ?? 0.0).toDouble(),
    );
  }

  @override
  String toString() => '$nome (R\$ ${valorDiaria.toStringAsFixed(2)}/dia)';
}
