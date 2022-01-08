import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jmm_task/model/card_detail_model.dart';

class FirestoreDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CardDetail>> getCardDetailDocument() async {
    final collection = await firestore.collection('card_detail').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> document =
        collection.docs;
    final cardDetails =
        document.map((e) => CardDetail.fromJson(e.data())).toList();
    cardDetails.forEach((element) {
      print("element.country======= ${element.country}");
      print("element.city======= ${element.city}");
    });
    print(cardDetails);
    return cardDetails;
  }
}
