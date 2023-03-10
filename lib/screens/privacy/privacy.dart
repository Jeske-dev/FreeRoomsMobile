import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/freerooms_bloc.dart';
import '../../blocs/update_bloc.dart';
import '../home/card.dart';
import '../home/date.dart';
import '../menu/menu.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF212121),
      body: ListView(
        children: [
          Lottie.asset('assets/privacy.json', fit: BoxFit.contain, height: 200, repeat: false),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*3/4,
              child: Text(
                'Datenschutz',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Der Schutz deiner Daten ist uns wichtig. Deshalb sammeln wir prinzipiell keine Daten von dir.\nDie einzige Außnahme bildet hier das Sammeln von Daten durch Firebase (Google). Hier wird aber jediglich nur getrackt, wie viele Geräte die Schnittstelle zu Firestore (Datenbank) nutzen.\n\nDu kannst dir natürlich auch selbst ein Bild von dem Code machen. Auf Github findest du den vollen Code der App.',
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white60),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          GestureDetector(
            onTap: () async {
              Uri _url = Uri.parse('https://github.com/Jeske-dev/FreeRoomsMobile');
              if (!await launchUrl(_url)) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Discordlink konnte nicht geöffnet werden.')));
              }
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_forward_rounded, color: Colors.white38),
                const SizedBox(width: 8),
                Text(
                  'Github',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white60),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}