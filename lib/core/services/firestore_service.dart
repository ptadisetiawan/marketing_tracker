import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final instance = FirestoreService();

  void setDataLokasi({
    String id,
    Map<String, dynamic> data,
    bool merge = false,
  }) async {
    print('$id: $data');
    final reference =
        Firestore.instance.collection('user_location').document(id);
    await reference.setData(data, merge: merge);
  }

   Stream<QuerySnapshot> getLokasiList() {
    return Firestore.instance.collection('user_location').snapshots();
  }
}
