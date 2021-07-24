import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBUtils {
  DBUtils._();

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'db_confere.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS products(id TEXT PRIMARY KEY, name TEXT, price REAL, promotion_price REAL, discount_percentage REAL, available INTEGER, img_url TEXT);',
        );
      },
    );
  }

  static Future<dynamic> getData({required String table}) async {
    final db = await DBUtils.database();
    return db.query(table);
  }

  static Future<void> insertOrUpdate(
      {required String table, required Map<String, Object?> values}) async {
    final db = await DBUtils.database();
    await db.insert(
      table,
      values,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> remove(
      {required String table, required String id}) async {
    final db = await DBUtils.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future close() async => (await DBUtils.database()).close();
}
