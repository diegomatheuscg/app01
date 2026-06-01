import 'package:app01/database/DatabaseHelper.dart';
import 'package:app01/model/Automovel.dart';
import 'package:app01/model/Categoria.dart';

class AutomovelDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String> inserir(Automovel automovel) async {
    final db = await _dbHelper.database;
    await db.insert('automoveis', automovel.toMap());
    return automovel.placa;
  }

  Future<List<Automovel>> listar() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.*, c.nome, c.valorDiaria, c.valorSeguro
      FROM automoveis a
      JOIN categorias c ON a.categoriaId = c.id
      ORDER BY a.placa
    ''');

    List<Automovel> automoveis = [];
    for (var map in maps) {
      Categoria categoria = Categoria(
        id: map['categoriaId'],
        nome: map['nome'],
        valorDiaria: (map['valorDiaria'] ?? 0.0).toDouble(),
        valorSeguro: (map['valorSeguro'] ?? 0.0).toDouble(),
      );
      automoveis.add(Automovel.fromMap(map, categoria));
    }
    return automoveis;
  }

  Future<void> atualizar(Automovel automovel) async {
    final db = await _dbHelper.database;
    await db.update(
      'automoveis',
      automovel.toMap(),
      where: 'placa = ?',
      whereArgs: [automovel.placa],
    );
  }

  Future<void> deletar(String placa) async {
    final db = await _dbHelper.database;
    await db.delete(
      'automoveis',
      where: 'placa = ?',
      whereArgs: [placa],
    );
  }
}
