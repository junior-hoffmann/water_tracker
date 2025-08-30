import 'package:agua/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkButton extends StatelessWidget {
  const DrinkButton({
    super.key,
    required this.amount,
    required this.text,
    required this.image,
  });

  final String text;
  final int amount;
  final String image;

  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<DrinkProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onDoubleTap: () {
          waterProvider.save(amount: amount);
        },
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Dê dois toques para adicionar",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(66, 158, 158, 158),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: MediaQuery.of(context).size.width / 2.3,
          height: MediaQuery.of(context).size.width / 5.5,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  image,
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
