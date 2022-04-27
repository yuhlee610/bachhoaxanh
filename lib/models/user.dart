import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String name;
  String phoneNumber;

  UserModel({required this.id, required this.email,
    required this.name, this.phoneNumber = '090xxxxxxx'});

  UserModel.fromSnapShot(DocumentSnapshot snapshot) :
      id = snapshot['uid'],
      email = snapshot['email'],
      name = snapshot['name'],
      phoneNumber = snapshot['phone'];
}
