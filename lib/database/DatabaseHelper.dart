import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'locadora.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Tabela de Categorias
    await db.execute('''
      CREATE TABLE IF NOT EXISTS categorias (
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        valorDiaria REAL NOT NULL,
        valorSeguro REAL NOT NULL
      )
    ''');

    // Tabela de Automóveis
    await db.execute('''
      CREATE TABLE IF NOT EXISTS automoveis (
        placa TEXT PRIMARY KEY,
        marca TEXT NOT NULL,
        modelo TEXT NOT NULL,
        anoFabricacao INTEGER NOT NULL,
        anoModelo INTEGER NOT NULL,
        cor TEXT NOT NULL,
        renavam TEXT NOT NULL,
        combustivel TEXT NOT NULL,
        quilometragemAtual REAL NOT NULL,
        categoriaId TEXT NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (categoriaId) REFERENCES categorias(id)
      )
    ''');

    // Inserir dados iniciais
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Verificar se já existe dados
    List<Map> existingCategorias =
        await db.query('categorias', limit: 1);

    if (existingCategorias.isEmpty) {
      // Inserir categorias iniciais
      await db.insert('categorias', {
        'id': 'cat1',
        'nome': 'Econômico',
        'valorDiaria': 100.0,
        'valorSeguro': 50.0,
      });

      await db.insert('categorias', {
        'id': 'cat2',
        'nome': 'SUV Premium',
        'valorDiaria': 250.0,
        'valorSeguro': 150.0,
      });

      await db.insert('categorias', {
        'id': 'cat3',
        'nome': 'Luxo',
        'valorDiaria': 500.0,
        'valorSeguro': 300.0,
      });

      // Inserir automóveis iniciais
      await db.insert('automoveis', {
        'placa': 'ABC1234',
        'marca': 'Fiat',
        'modelo': 'Uno',
        'anoFabricacao': 2020,
        'anoModelo': 2021,
        'cor': 'Branco',
        'renavam': '12345678901',
        'combustivel': 'Gasolina',
        'quilometragemAtual': 5000.0,
        'categoriaId': 'cat1',
        'status': 'disponivel',
      });

      await db.insert('automoveis', {
        'placa': 'XYZ5678',
        'marca': 'Toyota',
        'modelo': 'Corolla',
        'anoFabricacao': 2021,
        'anoModelo': 2022,
        'cor': 'Prata',
        'renavam': '98765432109',
        'combustivel': 'Gasolina',
        'quilometragemAtual': 8000.0,
        'categoriaId': 'cat2',
        'status': 'disponivel',
      });

      await db.insert('automoveis', {
        'placa': 'BMW1001',
        'marca': 'BMW',
        'modelo': 'X5',
        'anoFabricacao': 2022,
        'anoModelo': 2023,
        'cor': 'Preto',
        'renavam': '11111111111',
        'combustivel': 'Gasolina',
        'quilometragemAtual': 3000.0,
        'categoriaId': 'cat3',
        'status': 'disponivel',
      });
    }
  }
}
