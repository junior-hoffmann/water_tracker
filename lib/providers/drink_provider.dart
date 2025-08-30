import 'package:agua/data/drink_dao.dart';
import 'package:agua/data/drink_preferences.dart';
import 'package:agua/models/day_report.dart';
import 'package:agua/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkProvider extends ChangeNotifier {
  int progress = 0;
  int target = 0;
  int waterDrank = 0;
  List<Drink> drankTodayList = [];
  List<Drink> historyDrinks = [];
  List<DayReport> dayReports = [];

  void newTarget({required int target}) {
    changeTarget(drinkTarget: target);
    this.target = target; // Atualiza o target diretamente
    _calculateProgress(); // Recalcula o progresso
    notifyListeners();
  }

  void loadTarget() async {
    await getDrinkTarget().then((value) {
      target = value;
      _calculateProgress(); // Recalcula o progresso após carregar o target
      notifyListeners();
    });
  }

  Future<void> save({required int amount}) async {
    await DrinkDao().save(amount: amount);
    await loadTodayDrinks();
    await loadAllDrinks();
  }

  Future<void> delete({required DateTime date}) async {
    await DrinkDao().delete(date: date.toString());
    await loadTodayDrinks();
    await loadAllDrinks();
  }

  void _calculateProgress() {
    waterDrank = 0;
    for (Drink drink in drankTodayList) {
      waterDrank += drink.amount;
    }
    double percent =
        target > 0 ? (waterDrank / target) : 0; // Evita divisão por zero
    progress = (target * percent).floor();
    notifyListeners();
  }

  void _generateReports(){
    dayReports = [];
    for (Drink drink in historyDrinks) {
      DateTime date = DateTime(drink.date.year, drink.date.month, drink.date.day);
      DayReport existingReport = dayReports.firstWhere(
        (report) => report.date == date,
        orElse: () => DayReport(date: date),
      );
      if (!dayReports.contains(existingReport)) {
        dayReports.add(existingReport);
      }
      existingReport.drinks.add(drink);
    }
    notifyListeners();
  }

  Future<void> loadAllDrinks() async {
    historyDrinks = await DrinkDao().findAll();
    _generateReports();
    notifyListeners();
  }

  Future<void> loadTodayDrinks() async {
    final today = DateTime.now();
    final dateString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    drankTodayList = await DrinkDao().findDay(date: dateString);
    _calculateProgress();
  }
}
