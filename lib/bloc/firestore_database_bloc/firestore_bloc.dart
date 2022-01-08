import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmm_task/bloc/firestore_database_bloc/firestore_event.dart';
import 'package:jmm_task/bloc/firestore_database_bloc/firestore_state.dart';
import 'package:jmm_task/model/card_detail_model.dart';
import 'package:jmm_task/repository/database.dart';

class FireStoreBLoc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreDatabase database = FirestoreDatabase();

  FireStoreBLoc(InitialFirestoreState initialFirestoreState)
      : super(InitialFirestoreState()) {
    on<FetchedDocumentDataFromFirestoreevent>((event, emit) async {
      emit(LoadingFirestoreDocumentstate());
      try {
        List<CardDetail> cardDetails = await database.getCardDetailDocument();
        print('in bloccc $cardDetails');

        emit(FetchedFirestoreDocumentstate(cardDetail: cardDetails));
      } catch (error) {
        emit(FailureFirestoreDocumentstate(error: error.toString()));
      }
    });
  }
}
