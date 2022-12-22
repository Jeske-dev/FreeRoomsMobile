import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/update_bloc.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF212121),
      body: BlocBuilder<UpdateBloc, UpdateState>(
        builder: (context, state) {
          if (state is UpdateLoaded) {
            return ListView(
              children: [
                BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: state.directUrl,
                  color: Colors.white,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Das Teilen der App ist ausdrücklich nur mit Schülern des Gymnasium Burgstädt erlaubt.',
                    textAlign: TextAlign.center,
                    textWidthBasis: TextWidthBasis.parent,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.white38),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Link kopieren',
                        textAlign: TextAlign.center,
                        textWidthBasis: TextWidthBasis.parent,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white60),
                      ),
                      const SizedBox(height: 4.0),
                      IconButton(
                        onPressed: () async {
                          Clipboard.setData(ClipboardData(text: state.directUrl)).then((_) => 
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link kopiert!')))
                          );
                        }, 
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.white60,
                        )
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      )
    );
  }
}