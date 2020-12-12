import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/injector.dart';

class UserProvider extends ChangeNotifier {
  FirestoreService firestoreService = locator<FirestoreService>();
  List<User> _users;
  List<User> get users => _users;
  User _user;
  User get user => _user;

  void getUserList() async {
    var results = await firestoreService.getUserList();
    _users = results.documents
        .map((doc) => User.fromMap(doc.data, doc.documentID))
        .toList();
    notifyListeners();
  }

  void getUser(String email) async {
    var results = await firestoreService.getUser(email);
    _user = new User(
        nama: results['nama'] ?? '',
        alamat: results['alamat'] ?? '',
        telp: results['telp'] ?? '',
        perusahaan: results['perusahaan'] ?? '',
        alamatPerusahaan: results['alamat_perusahaan'] ?? '');
     notifyListeners();   
  }

  Future updateUser(User data,String email) async{
    await firestoreService.updateUser(data.toJson(), email);
    return ;
  }
}
