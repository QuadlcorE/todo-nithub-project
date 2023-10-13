import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/user.dart';
import 'package:todo/services/database.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a user object
  TodoUser? _userFromFireBaseUser(User? user) {
    return user != null ? TodoUser(uid: user.uid) : null;
  }

  Stream<TodoUser?> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future<String?> getUserID() async {
    User? user = _auth.currentUser;
    return user?.uid;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An error occurred: ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "An error occurred: ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
