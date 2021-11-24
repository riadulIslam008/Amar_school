import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FirebaseAuthService {
  Future<UserCredential> signin(
      {@required String email, @required String password});
  Future<UserCredential> signup(
      {@required String email, @required String password});
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);
  @override
  Future<UserCredential> signin({String email, String password}) async {
    final UserCredential _userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return _userCredential;
  }

  @override
  Future<UserCredential> signup({String email, String password}) async {
    final UserCredential _userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return _userCredential;
  }
}
