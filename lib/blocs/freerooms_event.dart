part of 'freerooms_bloc.dart';

@immutable
abstract class FreeroomsEvent extends Equatable{
  const FreeroomsEvent();
}

class LoadFreeRooms extends FreeroomsEvent {

  final Map<DateTime, List<List<String>>> freeRooms;
  final DateTime lastUpdated;

  const LoadFreeRooms({
    required this.freeRooms,
    required this.lastUpdated
  });

  @override
  List<Object?> get props => [freeRooms, lastUpdated];
}

class ChangeSelectedDate extends FreeroomsEvent {

  final DateTime selectedDate;

  const ChangeSelectedDate({
    required this.selectedDate
  });

  @override
  List<Object?> get props => [];

}

class NextDate extends FreeroomsEvent {

  const NextDate();

  @override
  List<Object?> get props => [];

}

class PreviousDate extends FreeroomsEvent {

  const PreviousDate();

  @override
  List<Object?> get props => [];

}

class ShowErrorPage extends FreeroomsEvent {

  const ShowErrorPage();

  @override
  List<Object?> get props => [];

}

// rent room
// disrent room