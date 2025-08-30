// ignore_for_file: use_build_context_synchronously

import 'package:agua/screens/widgets/warnings.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageCreditsScreen extends StatelessWidget {
  const ImageCreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créditos das Imagens')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Imagens retiradas do site https://www.flaticon.com/'),
            trailing: IconButton(
              onPressed: () {
                _openLink(link: 'https://www.flaticon.com/', context: context);
              },
              icon: Icon(HugeIcons.strokeRoundedInternet),
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              'images/water_drop.png',
              width: 40,
              height: 40,
            ),
            subtitle: Text('Fonte: Flaticon\nAutor: Freepik'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/clean',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
          ListTile(
            leading: Image.asset('images/fill.png', width: 40, height: 40),
            subtitle: Text('Fonte: Flaticon\nAutor: andinur'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/routine',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
          ListTile(
            leading: Image.asset('images/gallon.png', width: 40, height: 40),
            subtitle: Text('Fonte: Flaticon\nAutor: Freepik'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/water-bottle',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
          ListTile(
            leading: Image.asset('images/mug.png', width: 40, height: 40),
            subtitle: Text('Fonte: Flaticon\nAutor: Smashicons'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/mug',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
          ListTile(
            leading: Image.asset(
              'images/water-cycle.png',
              width: 40,
              height: 40,
            ),
            subtitle: Text('Fonte: Flaticon\nAutor: Freepik'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/water',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
          ListTile(
            leading: Image.asset('images/water.png', width: 40, height: 40),
            subtitle: Text('Fonte: Flaticon\nAutor: Freepik'),
            onTap: () {
              _openLink(
                link: 'https://www.flaticon.com/free-icons/bottle',
                context: context,
              );
            },
            trailing: Icon(HugeIcons.strokeRoundedArrowRight01),
          ),
        ],
      ),
    );
  }

  void _openLink({required String link, required BuildContext context}) async {
    final Uri url = Uri.parse(link);
    if (await launchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showWarning(
        context: context,
        message: 'Não foi possível abrir o link.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
}
