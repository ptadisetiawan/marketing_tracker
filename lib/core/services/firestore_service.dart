import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final instance = FirestoreService();

  void setDataLokasi({
    String id,
    Map<String, dynamic> data,
    bool merge = false,
  }){
    final reference =
        Firestore.instance.collection('user_location').document(id);
    print('$id: $data');
    reference.setData(data, merge: merge);
  }
}
