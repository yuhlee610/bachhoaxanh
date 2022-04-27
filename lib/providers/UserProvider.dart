import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel value) {
    _user = value;
  }

  void fetchUser(String email) {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs[0]["first_name"]);
    });
  }

  Future<bool> signIn(email, password) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user?.uid)
          .get();
      user = UserModel.fromSnapShot(snapshot);
      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user?.uid)
            .set({
          'name': name,
          'email': email,
          'uid': result.user?.uid,
          'phone': '088xxxxxxxx',
          'cart': [],
          'favorite': []
        });
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
    return Future.delayed(Duration.zero);
  }
}
