import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String proprietyTable = "proprietyTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String latitudeColumn = "latitudeColumn";
final String sandColumn = "sandColumn";

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
    final path = join(databasePath, 'propriety.db');

    return await openDatabase(
        path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $proprietyTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $latitudeColumn TEXT,"
              "$sandColumn TEXT)"
      );
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
        columns: [idColumn, nameColumn, latitudeColumn, sandColumn],
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
    return await dbPropriety.delete(
        proprietyTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updatePropriety(Propriety propriety) async {
    Database dbPropriety = await db;
    return await dbPropriety.update(
        proprietyTable, propriety.toMap(), where: "$idColumn = ?",
        whereArgs: [propriety.id]);
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

  int id;
  String name;
  String latitude;
  String sand;

  Propriety();

  Propriety.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    latitude = map[latitudeColumn];
    sand = map[sandColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      latitudeColumn: latitude,
      sandColumn: sand,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Propriedade(id: $id, name: $name, latitude: $latitude, sand: $sand)";
  }
}

//Mudar nome da sua tabela e os campos
