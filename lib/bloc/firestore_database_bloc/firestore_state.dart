import 'package:jmm_task/model/card_detail_model.dart';

abstract class FirestoreState {}

class InitialFirestoreState extends FirestoreState {}

class LoadingFirestoreDocumentstate extends FirestoreState {}

class FetchedFirestoreDocumentstate extends FirestoreState {
  final List<CardDetail> cardDetail;
  FetchedFirestoreDocumentstate({required this.cardDetail});
}

class FailureFirestoreDocumentstate extends FirestoreState {
  String error;
  FailureFirestoreDocumentstate({required this.error});
}
