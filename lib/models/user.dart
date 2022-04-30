import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  List<String> address = [];
  String name;
  String phoneNumber;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.address,
      required this.phoneNumber});

  UserModel.fromSnapShot(DocumentSnapshot snapshot)
      : id = snapshot['uid'],
        email = snapshot['email'],
        name = snapshot['name'],
        address = List<String>.from(snapshot['address']),
        phoneNumber = snapshot['phone'];
}
