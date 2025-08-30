import 'package:agua/models/day_report.dart';
import 'package:agua/models/drink.dart';
import 'package:agua/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime firstDrink({required BuildContext context}) {
  List<Drink> drinks =
      Provider.of<DrinkProvider>(context, listen: false).historyDrinks;
  if (drinks.isEmpty) {
    return DateTime.now();
  }
  drinks.sort((a, b) => a.date.compareTo(b.date));
  return drinks.first.date;
}

bool isGoalAchieved({required DateTime date, required BuildContext context}) {
  List<DayReport> reports =
      Provider.of<DrinkProvider>(context, listen: false).dayReports;
  if (reports.isEmpty) {
    return false;
  }
  DayReport? report = reports.firstWhere(
    (r) =>
        r.date.year == date.year &&
        r.date.month == date.month &&
        r.date.day == date.day,
    orElse: () => DayReport(date: date), // Retorna um DayReport vazio se não encontrar
  );
  return report.goalAchieved(context: context);
}
