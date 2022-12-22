import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/update_bloc.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) {
        if (state is UpdateLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            backgroundColor: Color(0xFF212121),
            body: ListView(
              children: [
                Lottie.asset('assets/download.json', fit: BoxFit.contain, height: 200),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*3/4,
                    child: Text(
                      state.currentVersionNumber == state.latestVersionNumber ? 'Du bist bereits auf dem neusten Stand 👍' : 'Update Verfügbar!',
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
                      state.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white60),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                state.currentVersionNumber == state.latestVersionNumber ? Container() :_getDownloadUpdateButton(context, state.directUrl),
                GestureDetector(
                  onTap: () async {
                    Uri _url = Uri.parse(
                        state.gerneralUrl);
                    if (!await launchUrl(_url)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Seite konnte leider nicht geöffet werden')));
                    }
                  },
                  child: Center(
                    child: Text(
                      'alle Versionen anschauen',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white60),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10, thickness: 1),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Version: ${state.currentVersionNumber}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white38),
                    ),
                    Text(
                      'Aktuellste Version: ${state.latestVersionNumber}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white38),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            backgroundColor: const Color(0xFF212121),
          );
        }
      },
    );
  }

  Widget _getDownloadUpdateButton(BuildContext context, String directUrl) {
    return GestureDetector(
      onTap: () async {
        Uri _url = Uri.parse(
            directUrl);
        if (!await launchUrl(_url)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Seite konnte leider nicht geöffet werden')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff9C6ACC),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Update herunterladen',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
