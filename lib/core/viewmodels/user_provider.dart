import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/injector.dart';

class UserProvider extends ChangeNotifier{
  FirestoreService firestoreService = locator<FirestoreService>();
  List<User> _users;
  List<User> get users => _users;

  void getUserList() async {
    var results = await firestoreService.getUserList();
    _users = results.documents
            .map((doc) => User.fromMap(doc.data, doc.documentID))
            .toList();
    notifyListeners();
  }
}