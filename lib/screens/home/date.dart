import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeroomsmobile/blocs/freerooms_bloc.dart';

class DateWidget extends StatelessWidget {
  const DateWidget(this.date, {this.selected=false, super.key});

  final DateTime date;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: selected ? 0.0 : 12.0),
      child: GestureDetector(
        onTap: () {
          if (!selected) {
            context.read<FreeroomsBloc>().add(ChangeSelectedDate(selectedDate: date));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date.day == DateTime.now().day
               ? 'TODAY'
               : date.day.toString(),
              style: TextStyle(
                fontSize: 48,
                color: selected
                  ? Colors.white
                  : Colors.white54
              ),
            ),
            selected 
             ? SizedBox(
                 width: 12,
                 child: Center(
                   child: Container(
                     height: 6,
                     width: 6,
                     decoration: BoxDecoration(
                       color: Colors.purple,
                       borderRadius: BorderRadius.circular(4)
                     ),
                   ),
                 ),
               )
             : Container()
          ],
        ),
      ),
    );
  }
}