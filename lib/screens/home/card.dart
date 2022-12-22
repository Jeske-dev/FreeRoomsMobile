import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeroomsmobile/blocs/freerooms_bloc.dart';
import 'package:freeroomsmobile/screens/details/details.dart';
import 'package:freeroomsmobile/screens/home/home.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    super.key, 
    required this.backgroundColor, 
    required this.timeSpan, 
    required this.freeRooms,
    this.recommendedFreeRooms,
    this.viewDetailsEnabled=false
  });

  final Color backgroundColor;
  final TimeSpanHelp timeSpan;
  final List<String> freeRooms;
  List<String>? recommendedFreeRooms = [];
  final bool viewDetailsEnabled;

  @override
  Widget build(BuildContext context) {
    
    String bigRoom = 'Nope';
    String otherRooms = 'Keine Zimmer frei';

    try {

      recommendedFreeRooms??=recommend([...freeRooms], 5);
      int maxLength = recommendedFreeRooms!.length;
      String _otherRooms = recommendedFreeRooms!.getRange(1, min(5, maxLength)).toString();
      bigRoom = recommendedFreeRooms!.first;
      otherRooms = _otherRooms.substring(1, _otherRooms.length-1).replaceAll(RegExp(r','), ' ');

    } catch (e) {}
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: GestureDetector(
        onTap: () {
          if (viewDetailsEnabled) {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => DetailsScreen(
                color: backgroundColor, 
                timeSpan: timeSpan, 
                freeRooms: freeRooms,
                recommendedFreeRooms: recommendedFreeRooms!
              )),       
            );
          }
        },
        child: Hero(
          tag: '${timeSpan.startHr}${timeSpan.startMin}${timeSpan.endHr}${timeSpan.endMin}${freeRooms.toString()}${backgroundColor.toString()}',
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SideBar(context, timeSpan: timeSpan,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Vorschlag:',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.black26
                            ),
                      ),
                      Text(
                        bigRoom,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        otherRooms,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.black54),
                      )
                    ],
                  ),
                ),
                viewDetailsEnabled ? const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black26),
                    )
                  ),
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  List<String> recommend(List<String> list, int maxlength) {
    List<String> recommend = [];
    while (recommend.length < maxlength && list.isNotEmpty) {
      var item = list[Random().nextInt(list.length)];
      if (!recommend.contains(item)) {
        recommend.add(item);
        list.remove(item);
      }
    }
    return recommend;
  }

}

class SideBar extends StatelessWidget {
  SideBar(this.context, {required this.timeSpan, super.key});

  BuildContext context;
  final TimeSpanHelp timeSpan;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeSpan.startHr,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          timeSpan.startMin,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.black38),
        ),
        Container(
          height: 32,
          width: 1.2,
          color: Colors.black54,
        ),
        Text(
          timeSpan.endHr,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          timeSpan.endMin,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.black38),
        ),
      ],
    );
  }
}
