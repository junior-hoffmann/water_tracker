// ignore_for_file: use_build_context_synchronously

import 'package:agua/screens/about/image_credits_screen.dart';
import 'package:agua/screens/widgets/warnings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget aboutDialog({required BuildContext context}) {
  return AlertDialog(
    title: const Text('Sobre o App'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          const Text(
            'Esse app foi feito para ajudar você a monitorar sua ingestão de água diária, promovendo hábitos saudáveis e mantendo você hidratado!',
          ),
          const SizedBox(height: 10),
          const Text('Versão: 1.0.0'),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImageCreditsScreen(),
                ),
              );
            },
            child: const Text(
              'Créditos das imagens',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(height: 10),
          // Linha com "Desenvolvido por:" + botão no nome
          Row(
            children: [
              const Text('Desenvolvido por: '),
              GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(
                    'https://www.instagram.com/juniocode',
                  );
                  if (await launchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showWarning(
                      context: context,
                      message: 'Não foi possível abrir o Instagram.',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                },
                child: const Text(
                  'Junior Hoffmann',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Ok'),
      ),
    ],
  );
}
