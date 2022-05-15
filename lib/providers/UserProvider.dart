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

  void addAddress(String userId, String newAddress) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'address': FieldValue.arrayUnion([newAddress])});
    _user.address.add(newAddress);
    notifyListeners();
  }
  
  void updateName(String userId, String newName) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'name': newName});
    _user.name = newName;
    notifyListeners();
  }

  void updatePhone(String userId, String phone) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'phone': phone});
    _user.phoneNumber = phone;
    notifyListeners();
  }

  void changePassword(String currentPassword, String newPassword) async  {
    final crrUser = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: _user.email, password: currentPassword);

    crrUser?.reauthenticateWithCredential(cred).then((value) {
      crrUser.updatePassword(newPassword).then((_) {
        print("Change password success");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
      });
    });
  }

  void removeAddress(String userId, String rmAddress) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'address': FieldValue.arrayRemove([rmAddress])});
    _user.address.remove(rmAddress);
    notifyListeners();
  }

  void editAddress(String userId, String newAddress, String oldAddress) {
    int index = _user.address.indexOf(oldAddress);
    _user.address[index] = newAddress;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'address': _user.address});
    notifyListeners();
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

  Future<bool> signUp(String email, String password, String name,
      String address, String phone) async {
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
          'phone': phone,
          'address': [address]
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
