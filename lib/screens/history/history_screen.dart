// ignore_for_file: depend_on_referenced_packages

import 'package:agua/models/day_report.dart';
import 'package:agua/providers/drink_provider.dart';
import 'package:agua/util/image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  final DayReport dayReport;
  const HistoryScreen({super.key, required this.dayReport});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico do dia ${DateFormat("dd/MM/yy").format(widget.dayReport.date)}',
        ),
      ),
      body: Consumer<DrinkProvider>(
        builder: (context, provider, child) {
          // pega o relatório atualizado referente ao dia aberto
          final updatedReport = provider.dayReports.firstWhere(
            (report) =>
                DateFormat("dd/MM/yy").format(report.date) ==
                DateFormat("dd/MM/yy").format(widget.dayReport.date),
            orElse: () => DayReport(date: widget.dayReport.date),
          );

          return ListView.separated(
            separatorBuilder:
                (context, index) =>
                    const Divider(color: Colors.lightBlueAccent),
            itemCount: updatedReport.drinks.length,
            itemBuilder: (context, index) {
              final drink = updatedReport.drinks[index];
              return ListTile(
                leading: Image.asset(
                  getImage(amount: drink.amount),
                  width: 30,
                  height: 30,
                ),
                title: Text(
                  "${drink.amount} ml às ${DateFormat("HH:mm").format(drink.date)}",
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    HugeIcons.strokeRoundedDelete02,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmar Exclusão'),
                          content: const Text(
                            'Tem certeza de que deseja excluir?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<DrinkProvider>(
                                  context,
                                  listen: false,
                                ).delete(date: drink.date);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Excluir',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
