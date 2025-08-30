import 'package:agua/models/drink.dart';
import 'package:agua/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayReport {
  DateTime date;
  List<Drink> drinks = [];

  DayReport({required this.date});

  int totalDrank() {
    int amount = 0;
    for (Drink drink in drinks) {
      amount += drink.amount;
    }
    return amount;
  }

  bool goalAchieved({required BuildContext context}) {
    return totalDrank() >= Provider.of<DrinkProvider>(context).target;
  }

  int percentDrank({required BuildContext context}) {
    return ((totalDrank() / Provider.of<DrinkProvider>(context).target) * 100)
        .floor();
  }
}
