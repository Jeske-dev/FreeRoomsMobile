import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

part 'freerooms_event.dart';
part 'freerooms_state.dart';

class FreeroomsBloc extends Bloc<FreeroomsEvent, FreeroomsState> {

  final CollectionReference freeRoomsCollection = FirebaseFirestore.instance.collection('freerooms');
  final CollectionReference historyCollection = FirebaseFirestore.instance.collection('history');

  FreeroomsBloc() : super(const FreeroomsInitial()) {
    on<LoadFreeRooms>(onLoadFreeRooms);
    on<ChangeSelectedDate>(onChangeSelectedDate);
    on<NextDate>(onNextDate);
    on<PreviousDate>(onPreviousDate);
    on<ShowErrorPage>(onShowErrorPage);

    freeRoomsCollection.snapshots().forEach((QuerySnapshot snapshot) async {
      
      DateTime date = DateFormat('yyyy.MM.dd HH:mm:ss').parse(
        await historyCollection.doc('history').get().then((snapshot) => snapshot.get('lastUpdated'))
      );

      add(
        LoadFreeRooms(
          freeRooms: _datesMapFromSnapshot(snapshot),
          lastUpdated: date
        )
      );
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (!(await InternetConnectionChecker().hasConnection)) {
        add(const ShowErrorPage());
      }
    });

  }

  FutureOr<void> onShowErrorPage(ShowErrorPage event, emit) async {
    if (state is! FreeroomsLoaded) {
      emit(
        const FreeroomsNoConnection()
      );
    }
  }

  FutureOr<void> onNextDate(NextDate event, emit) {
    
    FreeroomsState currentState = state;

    if (currentState is FreeroomsLoaded) {

      int index = currentState.freeRooms.keys.toList().indexOf(currentState.selectedDate);
      if (index < currentState.freeRooms.keys.length - 1) {
        emit(
          FreeroomsLoaded(
            selectedDate: currentState.freeRooms.keys.elementAt(index + 1), 
            freeRooms: currentState.freeRooms,
            lastUpdated: currentState.lastUpdated
          )
        );
      }

    }
  }

  FutureOr<void> onPreviousDate(PreviousDate event, emit) {

    FreeroomsState currentState = state;

    if (currentState is FreeroomsLoaded) {

      int index = currentState.freeRooms.keys.toList().indexOf(currentState.selectedDate);
      if (index > 0) {
        emit(
          FreeroomsLoaded(
            selectedDate: currentState.freeRooms.keys.elementAt(index - 1), 
            freeRooms: currentState.freeRooms,
            lastUpdated: currentState.lastUpdated
          )
        );
      }

    }
  }

  FutureOr<void> onLoadFreeRooms(LoadFreeRooms event, emit) {
    /*
    Map<DateTime, List<List<String>>> freeRoomsTest = {};
    for (int i = 0; i < 5; i++) {
      freeRoomsTest[DateTime.now().add(Duration(days: i))] = [['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],
                      ['1.08', '1.09', '1.11', '1.12', '1.13'],];
    }*/
    DateTime selectedDate = event.freeRooms.keys.first;
    try {
      selectedDate = event.freeRooms.keys.where((DateTime date) => DateUtils.isSameDay(date, DateTime.now())).first;
    } catch (e) {}
    emit(
      FreeroomsLoaded(
        freeRooms: event.freeRooms, 
        selectedDate: selectedDate,
        lastUpdated: event.lastUpdated
      )
    );
  }

  FutureOr<void> onChangeSelectedDate(ChangeSelectedDate event, emit) {
    
    FreeroomsState currentState = state;

    if (currentState is FreeroomsLoaded) {
      emit(
        FreeroomsLoaded(
          freeRooms: currentState.freeRooms, 
          selectedDate: event.selectedDate,
          lastUpdated: currentState.lastUpdated
        )
      );
    }

  }

  Map<DateTime, List<List<String>>> _datesMapFromSnapshot(QuerySnapshot<Object?> snapshot) {
    Map<DateTime, List<List<String>>> data = {};
    snapshot.docs.forEach((doc) {
      DateTime date = DateFormat('yyyy.MM.dd').parse(doc.id);

      String roomsRaw = doc.get('rooms');
      List<List<String>> rooms = (json.decode(roomsRaw) as List<dynamic>).map((element) => 
        List<double>.from(element).map((d) => d.toString()).toList()
      ).toList();

      data[date] = rooms;
    });
    return data;
  }

}
