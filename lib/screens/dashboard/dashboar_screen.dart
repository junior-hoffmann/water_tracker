// ignore_for_file: use_build_context_synchronously

import 'package:agua/providers/drink_provider.dart';
import 'package:agua/screens/widgets/circular_step_progress.dart';
import 'package:agua/screens/widgets/drank_today.dart';
import 'package:agua/screens/widgets/drawer.dart';
import 'package:agua/screens/widgets/drinks_size_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboarScreen extends StatefulWidget {
  const DashboarScreen({super.key});

  @override
  State<DashboarScreen> createState() => _DashboarScreenState();
}

class _DashboarScreenState extends State<DashboarScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega drinks do dia ao iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DrinkProvider>(context, listen: false).loadTodayDrinks();
      Provider.of<DrinkProvider>(context, listen: false).loadTarget();
      Provider.of<DrinkProvider>(context, listen: false).loadAllDrinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beber Água'), centerTitle: true),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            circularStepProgress(context: context),
            drinksSizeButtons(context: context),
            drankToday(context: context),
          ],
        ),
      ),
    );
  }
}
