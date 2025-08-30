// ignore_for_file: unnecessary_null_comparison

import 'package:agua/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

Widget circularStepProgress({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
      child: Consumer<DrinkProvider>(
        builder: (context, drinkProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          drinkProvider.waterDrank >= drinkProvider.target
                              ? const Icon(Symbols.trophy, color: Colors.amber)
                              : const SizedBox(),
                          Text(
                            drinkProvider.waterDrank >= drinkProvider.target
                                ? " Meta de água batida "
                                : "Você já tomou",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          drinkProvider.waterDrank >= drinkProvider.target
                              ? const Icon(Symbols.trophy, color: Colors.amber)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),

                // 🔹 Proteção contra target == 0
                drinkProvider.target <= 0
                    ? const Text(
                      "Defina sua meta de água",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                    : CircularStepProgressIndicator(
                      totalSteps: drinkProvider.target,
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      stepSize: 20,
                      unselectedColor: const Color.fromARGB(255, 194, 235, 254),
                      selectedColor: Colors.blue,
                      currentStep: drinkProvider.progress,
                      roundedCap: (p0, p1) => true,
                      child: Center(
                        child: Text(
                          "${drinkProvider.progress / 1000}L",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
