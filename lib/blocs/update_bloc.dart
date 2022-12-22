import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {

  static const String currentVersionNumber = "0.9.5";

  final CollectionReference updateCollection = FirebaseFirestore.instance.collection('update');

  UpdateBloc() : super(UpdateInitial()) {
    on<LoadUpdate>(onLoadUpdate);

    updateCollection.snapshots().forEach((_) async {
      String versionNumber = await updateCollection.doc('latest').get().then((snapshot) => snapshot.get('versionnumber'));
      String description = await updateCollection.doc('latest').get().then((snapshot) => snapshot.get('description'));
      String directLink = await updateCollection.doc('latest').get().then((snapshot) => snapshot.get('directlink'));
      String generalLink = await updateCollection.doc('general').get().then((snapshot) => snapshot.get('link'));

      add(
        LoadUpdate(
          currentVersionNumber: currentVersionNumber, 
          latestVersionNumber: versionNumber, 
          description: description, 
          directUrl: directLink, 
          generalUrl: generalLink
        )
      );
    });
  }

  FutureOr<void> onLoadUpdate(LoadUpdate event, emit) {
    emit(
      UpdateLoaded(
        currentVersionNumber: event.currentVersionNumber, 
        latestVersionNumber: event.latestVersionNumber, 
        description: event.description, 
        directUrl: event.directUrl, 
        gerneralUrl: event.generalUrl
      )
    );
  }
}
