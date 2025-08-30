import 'package:agua/data/drink_dao.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    "agua.db",
  ); //Junta o caminho usado pelo dispositivo para armazenar bancos de dados e concatena com o nome do banco de dados utilizado pelo app.

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(DrinkDao.tableSQL);
    },
    version: 1,
  );
}
