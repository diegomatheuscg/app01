class Locatario {
  final String cpf; // Identificador único
  final String nomeCompleto;
  final String numeroCnh;
  final String telefone;
  final String email;
  final String endereco;
  final DateTime dataNascimento;

  Locatario({
    required this.cpf,
    required this.nomeCompleto,
    required this.numeroCnh,
    required this.telefone,
    required this.email,
    required this.endereco,
    required this.dataNascimento,
  });

  int get idade {
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento.year;
    if (hoje.month < dataNascimento.month || (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      idade--;
    }
    return idade;
  }

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'nomeCompleto': nomeCompleto,
      'numeroCnh': numeroCnh,
      'telefone': telefone,
      'email': email,
      'endereco': endereco,
      'dataNascimento': dataNascimento.toIso8601String(),
    };
  }

  factory Locatario.fromMap(Map<String, dynamic> map) {
    return Locatario(
      cpf: map['cpf'] ?? '',
      nomeCompleto: map['nomeCompleto'] ?? '',
      numeroCnh: map['numeroCnh'] ?? '',
      telefone: map['telefone'] ?? '',
      email: map['email'] ?? '',
      endereco: map['endereco'] ?? '',
      dataNascimento: DateTime.parse(map['dataNascimento']),
    );
  }

  @override
  String toString() => '$nomeCompleto (CPF: $cpf)';
}