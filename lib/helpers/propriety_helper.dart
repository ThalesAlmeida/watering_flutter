import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String proprietyTable = "proprietyTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String latitudeColumn = "latitudeColumn";
final String sandColumn = "sandColumn";
final String ctaColumn = "ctaColumn";
final String craColumn = "craColumn";
final String fColumn = "fColumn";

//Cultivo
final String q0Column = "q0Column";
final String tempMaximaColumn = "tempMaximaColumn";
final String tempMinimaColumn = "tempMinimaColumn";
final String kcColumn = "kcColumn";
final String zColumn = "zColumn";

//Equipamento
final String eficienciaColumn = "eficienciaColumn";
final String intensidadeColumn = "intensidadeColumn";

class ProprietyHelper {
  static final ProprietyHelper _instance = ProprietyHelper.internal();

  factory ProprietyHelper() => _instance;

  ProprietyHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'farm.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $proprietyTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $latitudeColumn TEXT,"
          "$sandColumn TEXT, $ctaColumn TEXT, $craColumn TEXT, $fColumn TEXT, $q0Column TEXT, $tempMaximaColumn TEXT, $tempMinimaColumn TEXT, $kcColumn TEXT, $zColumn TEXT, $eficienciaColumn TEXT, $intensidadeColumn TEXT)");
    });
  }

  Future<Propriety> savePropriety(Propriety propriety) async {
    Database dbPropriety = await db;
    propriety.id = await dbPropriety.insert(proprietyTable, propriety.toMap());
    return propriety;
  }

  Future<Propriety> getPropriety(int id) async {
    Database dbPropriety = await db;
    List<Map> maps = await dbPropriety.query(proprietyTable,
        columns: [idColumn, nameColumn, latitudeColumn, sandColumn, ctaColumn, craColumn, fColumn, q0Column, tempMaximaColumn, tempMinimaColumn, kcColumn, zColumn, eficienciaColumn, intensidadeColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Propriety.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletePropriety(int id) async {
    Database dbPropriety = await db;
    return await dbPropriety
        .delete(proprietyTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updatePropriety(Propriety propriety) async {
    Database dbPropriety = await db;
    return await dbPropriety.update(proprietyTable, propriety.toMap(),
        where: "$idColumn = ?", whereArgs: [propriety.id]);
  }

  Future<List> getAllPropriety() async {
    Database dbPropriety = await db;
    List listMap = await dbPropriety.rawQuery("SELECT * FROM $proprietyTable");
    List<Propriety> listPropriety = List();
    for (Map map in listMap) {
      listPropriety.add(Propriety.fromMap(map));
    }
    return listPropriety;
  }

  Future<int> getNumber() async {
    Database dbPropriety = await db;
    return Sqflite.firstIntValue(
        await dbPropriety.rawQuery("SELECT COUNT(*) FROM $proprietyTable"));
  }

  Future close() async {
    Database dbPropriety = await db;
    dbPropriety.close();
  }
}

class Propriety {
  //Propriedade
  int id;
  String name;
  String latitude;
  String sand;
  String cta;
  String cra;
  String f;

  //Cultivo
  String q0;
  String tempMaxima;
  String tempMinima;
  String kc;
  String z;

  //Equipamento
  String eficiencia;
  String intensidade;

  Propriety();

  Propriety.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    latitude = map[latitudeColumn];
    sand = map[sandColumn];
    cta = map[ctaColumn];
    cra = map[craColumn];
    f = map[fColumn];
    q0 = map[q0Column];
    tempMaxima = map[tempMaximaColumn];
    tempMinima = map[tempMinimaColumn];
    kc = map[kcColumn];
    z = map[zColumn];
    eficiencia = map[eficienciaColumn];
    intensidade = map[intensidadeColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      latitudeColumn: latitude,
      sandColumn: sand,
      ctaColumn: cta,
      craColumn: cra,
      fColumn: f,
      q0Column: q0,
      tempMaximaColumn: tempMaxima,
      tempMinimaColumn: tempMinima,
      kcColumn: kc,
      zColumn: z,
      eficienciaColumn: eficiencia,
      intensidadeColumn: intensidade,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Propriedade(id: $id, name: $name, latitude: $latitude, sand: $sand, cta: $cra, cra: $cra, f: $f q0: $q0, tempMaxima: $tempMaxima, tempMinima: $tempMinima, kc: $kc, z: $z, $eficiencia: eficiencia, $intensidade: intensidade)";
  }
}


//Mudar nome da sua tabela e os campos
