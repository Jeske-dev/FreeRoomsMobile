import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeroomsmobile/blocs/freerooms_bloc.dart';
import 'package:freeroomsmobile/screens/home/card.dart';
import 'package:freeroomsmobile/screens/home/date.dart';
import 'package:freeroomsmobile/screens/menu/menu.dart';
import 'package:freeroomsmobile/screens/update/update.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../blocs/update_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<Color> colors = const [
    Color(0xffFBF651),
    Color(0xff9C6ACC),
    Color(0xffB8EC4A),
    Color(0xffFDFDFD),
    Color(0xffB2237D),
    Color(0xffFBF651),
    Color(0xff9C6ACC),
    Color(0xffB8EC4A),
    Color(0xffFDFDFD),
    Color(0xffB2237D),
  ];

  final List<TimeSpanHelp> timeSpans = const [
    TimeSpanHelp(startHr: '07', startMin: '40', endHr: '09', endMin: '10'),
    TimeSpanHelp(startHr: '09', startMin: '30', endHr: '11', endMin: '00'),
    TimeSpanHelp(startHr: '11', startMin: '45', endHr: '13', endMin: '15'),
    TimeSpanHelp(startHr: '13', startMin: '25', endHr: '14', endMin: '55'),
    TimeSpanHelp(startHr: '15', startMin: '00', endHr: '16', endMin: '30'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreeroomsBloc, FreeroomsState>(
      builder: (context, state) {
        if (state is FreeroomsLoaded) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                // next
                print('next');
                context.read<FreeroomsBloc>().add(const NextDate());
              } else if (details.primaryVelocity! > 0) {
                // previous
                print('previous');
                context.read<FreeroomsBloc>().add(const PreviousDate());
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xFF212121),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text('Free Rooms', style: GoogleFonts.quicksand(fontWeight: FontWeight.w600)),
                actions: 
                  [IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
                    }, 
                    icon: const Icon(Icons.more_vert)
                  ),],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 72,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              DateFormat("EEEE").format(state.selectedDate).toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.white54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: state.freeRooms.keys
                                    .toList()
                                    .asMap()
                                    .map((index, dateTime) => MapEntry(
                                        index,
                                        DateWidget(
                                          dateTime,
                                          selected:
                                              dateTime == state.selectedDate,
                                        )))
                                    .values
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: (state.freeRooms[state.selectedDate] ?? [])
                        .asMap()
                        .map((index, freeRoomsBlock) => MapEntry(
                            index,
                            CardWidget(
                              backgroundColor: colors[index],
                              timeSpan: timeSpans[index],
                              freeRooms: freeRoomsBlock,
                              viewDetailsEnabled: true,
                            )))
                        .values
                        .toList()
                    )
                  )
                ],
              ),
            ),
          );
        } else if (state is FreeroomsNoConnection) {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Center(
              child: Column(
                children: [
                  Text(
                    'Verbindungsfehler 😢',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white60),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Es konnte leider keine Verbindung zu Firebase aufgebaut werden. Stelle sicher, dass du mit dem Internet verbunden bist und die kommunikation deines Handys mit Firebase (Google) nicht blockst.',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white38),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.grey[900],
          );
        }
      },
    );
  }
}

class TimeSpanHelp {
  final String startHr;
  final String startMin;
  final String endHr;
  final String endMin;

  const TimeSpanHelp(
      {required this.startHr,
      required this.startMin,
      required this.endHr,
      required this.endMin});
}
