import 'package:agua/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Widget changeTargetDialog({required BuildContext context}) {
  final drinkProvider = Provider.of<DrinkProvider>(context, listen: false);
  int drinkTarget = Provider.of<DrinkProvider>(context, listen: true).target;
  TextEditingController controller = TextEditingController();
  return AlertDialog(
    title: const Text('Alterar Meta Diária'),
    content: TextField(
      autofocus: true,
      decoration: InputDecoration(hintText: "Sua meta atual é $drinkTarget ml"),
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancelar'),
      ),
      ElevatedButton(
        onPressed: () {
          // TODO: Validar se o campo não está vazio ou se é um número válido
          if (controller.text.isEmpty) return;
          drinkProvider.newTarget(target: int.parse(controller.text));
          Navigator.of(context).pop();
        },
        child: const Text('Salvar'),
      ),
    ],
  );
}
