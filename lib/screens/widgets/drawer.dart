// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:agua/models/day_report.dart';
import 'package:agua/providers/drink_provider.dart';
import 'package:agua/screens/history/history_screen.dart';
import 'package:agua/screens/widgets/about_dialog.dart';
import 'package:agua/screens/widgets/change_target_dialog.dart';
import 'package:agua/util/calendar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

Widget buildDrawer(BuildContext context) {
  List<DateTime?> _selectedDates = [];

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images/water_drop.png', width: 100, height: 100),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Sua meta atual é de ${Provider.of<DrinkProvider>(context).target} ml",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(HugeIcons.strokeRoundedTarget02),
          title: Text('Alterar Meta'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => changeTargetDialog(context: context),
            );
          },
        ),
        ListTile(
          leading: Icon(HugeIcons.strokeRoundedTransactionHistory),
          title: Text('Histórico'),
          onTap: () {
            showDialog<List<DateTime?>>(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SizedBox(
                    width: 325,
                    height: 400,
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        firstDate: firstDrink(context: context),
                        lastDate: DateTime.now(),
                        calendarType: CalendarDatePicker2Type.single,
                        dayBuilder: ({
                          required DateTime date,
                          BoxDecoration? decoration,
                          bool? isDisabled,
                          bool? isSelected,
                          bool? isToday,
                          TextStyle? textStyle,
                        }) {
                          BoxDecoration dayDecoration;
                          if (isSelected ?? false) {
                            dayDecoration = BoxDecoration(
                              color: Colors.blue.shade300,
                              shape: BoxShape.circle,
                            );
                          } else if (isToday ?? false) {
                            dayDecoration = BoxDecoration(
                              color: Colors.blueGrey.shade300,
                              shape: BoxShape.circle,
                            );
                          } else if (isGoalAchieved(
                            date: date,
                            context: context,
                          )) {
                            dayDecoration = BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            );
                          } else {
                            dayDecoration = BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            );
                          }

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: dayDecoration,
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style:
                                        textStyle?.copyWith(
                                          color:
                                              (isSelected ?? false) ||
                                                      (isToday ?? false)
                                                  ? Colors.white
                                                  : Colors.black,
                                        ) ??
                                        TextStyle(
                                          color:
                                              (isSelected ?? false) ||
                                                      (isToday ?? false)
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                  ),
                                ),
                              ),
                              if (isGoalAchieved(date: date, context: context))
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      value: _selectedDates,
                      onValueChanged: (dates) {
                        if (dates.isNotEmpty && dates[0] != null) {
                          try {
                            final drinkProvider = Provider.of<DrinkProvider>(
                              context,
                              listen: false,
                            );
                            final dayReport = drinkProvider.dayReports
                                .firstWhere(
                                  (report) {
                                    return report.date.year == dates[0].year &&
                                        report.date.month == dates[0].month &&
                                        report.date.day == dates[0].day;
                                  },
                                  orElse: () {
                                    return DayReport(date: dates[0]);
                                  },
                                );

                            Navigator.of(dialogContext).pop(dates);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (newContext) =>
                                        HistoryScreen(dayReport: dayReport),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Erro ao abrir HistoryScreen: $e',
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        Divider(color: Colors.grey[200],),
        ListTile(
          leading: Icon(HugeIcons.strokeRoundedPhoneDeveloperMode),
          title: Text('Sobre o app'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => aboutDialog(context: context),
            );
          },
        ),
      ],
    ),
  );
}
