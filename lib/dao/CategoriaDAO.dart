import 'package:app01/database/DatabaseHelper.dart';
import 'package:app01/model/Categoria.dart';

class CategoriaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String> inserir(Categoria categoria) async {
    final db = await _dbHelper.database;
    await db.insert('categorias', categoria.toMap());
    return categoria.id;
  }

  Future<List<Categoria>> listar() async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('categorias');
    return maps.map((map) => Categoria.fromMap(map)).toList();
  }

  Future<void> atualizar(Categoria categoria) async {
    final db = await _dbHelper.database;
    await db.update(
      'categorias',
      categoria.toMap(),
      where: 'id = ?',
      whereArgs: [categoria.id],
    );
  }

  Future<void> deletar(String id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'categorias',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
