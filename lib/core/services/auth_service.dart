import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';

import '../../injector.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthService with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  User _dbUser;
  Status _status = Status.Uninitialized;
  FirestoreService firestoreService = locator<FirestoreService>();

  AuthService.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChange);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  User get dbUser => _dbUser;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    _user = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChange(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      // print("tidak ada user");
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      var results = await firestoreService.getUser(firebaseUser.email);
      var dataUser = new User(
          nama: results['nama'] ?? '',
          alamat: results['alamat'] ?? '',
          telp: results['telp'] ?? '',
          perusahaan: results['perusahaan'] ?? '',
          alamatPerusahaan: results['alamat_perusahaan'] ?? '',
          email: firebaseUser.email ?? '');
      setDbUser(dataUser);
      // print("ada user");
    }
    notifyListeners();
  }

  void setDbUser(User user){
    _dbUser = user;
    notifyListeners();
  }
}
