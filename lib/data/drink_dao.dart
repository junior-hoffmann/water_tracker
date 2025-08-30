import 'package:agua/models/drink.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class DrinkDao {
  static const String tableSQL =
      'CREATE TABLE $_tableName('
      '$_date TEXT, '
      '$_amount TEXT)';

  static const String _tableName = "drinks";
  static const String _date = "date";
  static const String _amount = "amount";

  Map<String, dynamic> toMap({required int amount}) {
    final Map<String, dynamic> drinkMap = {};
    drinkMap[_date] = DateTime.now().toString();
    drinkMap[_amount] = amount.toString();
    return drinkMap;
  }

  save({required int amount}) async {
    final Database database = await getDatabase();
    Map<String, dynamic> drinkMap = toMap(amount: amount);
    await database.insert(_tableName, drinkMap);
  }

  Future<List<Drink>> findAll() async {
    final Database dataBase =
        await getDatabase(); //cria uma variavel com um banco de dados que é retornado do outro arquivo
    final List<Map<String, dynamic>> result = await dataBase.query(
      _tableName,
    ); //quando nos comunicamos com um banco de dados ele nos devolve sempre um Map com chaves e valores dos dados
    return toList(listDrink: result);
  }

  List<Drink> toList({required List<Map<String, dynamic>> listDrink}) {
    final List<Drink> drinks = [];
    for (Map<String, dynamic> line in listDrink) {
      try {
        final Drink drink = Drink(
          date: DateTime.parse(line[_date] ?? DateTime.now().toString()),
          amount: int.parse(line[_amount] ?? '0'),
        );
        drinks.add(drink);
      } catch (e) {
        // ignore: avoid_print
        print("Erro ao converter linha do banco: $e"); // Log de erro
      }
    }
    return drinks;
  }

  Future<List<Drink>> findDay({required String date}) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tableName,
      where: "$_date LIKE ?",
      whereArgs: ['$date%'], // Suporta busca por dia
    );
    return result.map((map) => Drink.fromMap(map)).toList();
  }

  delete({required String date}) async {
    final Database database = await getDatabase();
    await database.delete(
      _tableName,
      where: "$_date = ?",
      whereArgs: [date],
    );
  }
}
