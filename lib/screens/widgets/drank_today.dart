// ignore_for_file: depend_on_referenced_packages

import 'package:agua/providers/drink_provider.dart';
import 'package:agua/util/colors.dart';
import 'package:agua/util/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

Widget drankToday({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Consumer<DrinkProvider>(
      builder: (context, provider, child) {
        if (provider.drankTodayList.isEmpty) {
          return Text(
            "Você não bebeu água hoje",
            style: TextStyle(
              fontSize: 20,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Column(
          children: [
            Text(
              "Você bebeu hoje",
              style: TextStyle(
                fontSize: 20,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              separatorBuilder:
                  (context, index) => Divider(color: Colors.lightBlueAccent),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.drankTodayList.length,
              itemBuilder:
                  (context, index) => ListTile(
                    leading: Image.asset(
                      getImage(amount: provider.drankTodayList[index].amount),
                      width: 30,
                      height: 30,
                    ),
                    title: Row(
                      children: [
                        Text(
                          "${provider.drankTodayList[index].amount} ml às ${DateFormat("HH:mm").format(provider.drankTodayList[index].date)}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
            ),
          ],
        );
      },
    ),
  );
}


