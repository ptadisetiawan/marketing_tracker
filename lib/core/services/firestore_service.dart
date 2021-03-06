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

  void setHistoryLokasi({Map<String, dynamic> data}) async {
    final reference =
        Firestore.instance.collection('location_history');
    await reference.add(data);
  }

   Stream<QuerySnapshot> getLokasiList() {
    return Firestore.instance.collection('user_location').snapshots();
  }

  Future<QuerySnapshot> getUserList(){
    return Firestore.instance.collection('users').getDocuments();
  }

   Future<QuerySnapshot> getHistory(String email){
     return Firestore.instance.collection('location_history').where('email', isEqualTo: email).orderBy('waktu', descending: true).getDocuments();
  }

  Future<DocumentSnapshot> getUser(String email){
    return Firestore.instance.collection('users').document(email).get();
  }
  Future<void> updateUser(Map data , String email) {
    return Firestore.instance.collection('users').document(email).updateData(data) ;
  }
}
