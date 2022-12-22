import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freeroomsmobile/screens/home/home.dart';
import 'package:lottie/lottie.dart';

import '../home/card.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.color,
    required this.timeSpan,
    required this.freeRooms,
    required this.recommendedFreeRooms
  });

  final Color color;
  final TimeSpanHelp timeSpan;
  final List<String> freeRooms;
  final List<String> recommendedFreeRooms;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10)
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String _allFreeRooms = widget.freeRooms.toString();
    String allFreeRooms = _allFreeRooms.substring(1, _allFreeRooms.length - 1).replaceAll(RegExp(r','), ' ');

    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Lottie.asset(
                'assets/rabbitanimation.json', 
                width: MediaQuery.of(context).size.height/3,
                controller: controller,
                repeat: true,
                onLoaded: (p0) {
                  controller.forward();
                },
              ),
            )
          ),
          /*BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),*/
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                Navigator.pop(context);
              }
            },
            child: Column( // Is needed for min height of Card
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff111111),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(2, 2),
                          spreadRadius: 1
                        )
                      ]
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        CardWidget(
                          backgroundColor: widget.color, 
                          timeSpan: widget.timeSpan, 
                          freeRooms: widget.freeRooms,
                          recommendedFreeRooms: widget.recommendedFreeRooms,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Text(
                                'Alle freien Zimmer:',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white60
                                ),
                              ),
                              const SizedBox(height: 8),*/
                              Text(
                                allFreeRooms,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white38
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}