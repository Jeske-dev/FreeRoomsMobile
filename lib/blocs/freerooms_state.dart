part of 'freerooms_bloc.dart';

@immutable
abstract class FreeroomsState extends Equatable {
  const FreeroomsState();
}

class FreeroomsInitial extends FreeroomsState {
  const FreeroomsInitial();

  @override
  List<Object?> get props => [];
}

class FreeroomsNoConnection extends FreeroomsState {
  const FreeroomsNoConnection();

  @override
  List<Object?> get props => [];
}

class FreeroomsLoaded extends FreeroomsState {

  final Map<DateTime, List<List<String>>> freeRooms;
  final DateTime selectedDate;

  final DateTime lastUpdated;

  const FreeroomsLoaded({
    required this.selectedDate,
    required this.freeRooms,
    required this.lastUpdated
  });

  @override
  List<Object?> get props => [selectedDate, freeRooms, lastUpdated];
}
