import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeroomsmobile/screens/home/home.dart';
import 'package:freeroomsmobile/screens/privacy/privacy.dart';
import 'package:freeroomsmobile/screens/share/share.dart';
import 'package:freeroomsmobile/screens/update/update.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/update_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xFF212121),
      body: ListView(
        children: [

          Image.asset(
            'assets/rabbit.png', 
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.width/2,
            fit: BoxFit.fitHeight,
          ),

          const SizedBox(height: 24.0),

          Text(
            'Free Rooms',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 52,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Keine Lust die Freistunde in der Medio zu verbringen? Finde mit der Free Rooms App alle freien Zimmer. 😉',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: const Color.fromARGB(255, 117, 117, 117)
              ),
            ),
          ),

          const SizedBox(height: 20.0),

          const Divider(color: Colors.white10, thickness: 2),

          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareScreen()));
            },
            leading: Icon(Icons.share,
                color: HomeScreen.colors[0]),
            title: Text(
              'Teilen',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white60),
            ),
            subtitle: Text(
              'mittles QR-Code oder Link',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white38),
            ),
          ),
          ListTile(
            onTap: () async {
              Uri _url = Uri.parse('https://discord.gg/wmH8TRsJnt');
              if (!await launchUrl(_url)) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Discordlink konnte nicht geöffnet werden.')));
              }
            },
            leading: Icon(Icons.discord,
                color: HomeScreen.colors[1]),
            title: Text(
              'Discord',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white60),
            ),
            subtitle: Text(
              'werde Teil unserer Community',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white38),
            ),
          ),
          _VersionListTile(),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyScreen()));
            },
            leading: Icon(Icons.privacy_tip,
                color: HomeScreen.colors[3]),
            title: Text(
              'Datenschutz',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<UpdateBloc, UpdateState> _VersionListTile() {
    return BlocBuilder<UpdateBloc, UpdateState>(
          builder: (context, state) {
            if (state is UpdateLoaded) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateScreen()));
                },
                leading: Icon(Icons.system_update_rounded,
                    color: HomeScreen.colors[2]),
                title: Text(
                  'Version',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white60),
                ),
                subtitle: Text(
                  state.currentVersionNumber == state.latestVersionNumber ? 'Du bist auf dem neusten Stand' : 'Neue Version verfügbar!',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Color.fromARGB(255, 117, 117, 117)),
                ),
              );
            } else {
              return Container();
            }
          },
        );
  }
}
