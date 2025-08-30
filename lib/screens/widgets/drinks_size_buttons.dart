import 'package:agua/providers/drink_provider.dart';
import 'package:agua/screens/widgets/drink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Widget drinksSizeButtons({required BuildContext context}) {
  final waterProvider = Provider.of<DrinkProvider>(context);
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrinkButton(amount: 200, text: "200ml", image: "images/fill.png"),
            DrinkButton(amount: 300, text: "300ml", image: "images/mug.png"),
          ],
        ),
        InkWell(
          onTap: () {
            TextEditingController controller = TextEditingController();
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text("Quantidade personalizada"),
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Digite a quantidade de ml's",
                      ),
                      controller: controller,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          waterProvider.save(
                            amount: int.parse(controller.text),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Adicionar"),
                      ),
                    ],
                  ),
              // ignore: use_build_context_synchronously
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 5.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(97, 68, 137, 158),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Image.asset(
                //   "images/water-cycle.png",
                //   // width: MediaQuery.of(context).size.width / 10,
                // ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "images/water-cycle.png",
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("Quantidade personalizada"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrinkButton(amount: 500, text: "500ml", image: "images/water.png"),
            DrinkButton(amount: 1000, text: "1l", image: "images/gallon.png"),
          ],
        ),
      ],
    ),
  );
}
