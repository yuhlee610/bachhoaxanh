import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id, name, description, subcategory;
  List<String> image = [];
  int amount = 0, sold = 0, price = 0;

  Product(
      {required this.id,
        required this.name,
        required this.image,
        required this.description,
        required this.price,
        required this.subcategory,
        required this.amount,
        required this.sold});

  Product.fromMap(Map<String, dynamic> map) :
        id = map['id'],
        name = map['name'],
        image = List<String>.from(map['image']),
        description = map['description'],
        subcategory = map['subcategory'],
        amount = map['amount'],
        sold = map['sold'],
        price = map['price'];

  Product.fromSnapShot(DocumentSnapshot snapshot) :
      id = snapshot['id'],
      name = snapshot['name'],
      image = List<String>.from(snapshot['image']),
      description = snapshot['description'],
      subcategory = snapshot['subcategory'],
      amount = snapshot['amount'],
      sold = snapshot['sold'],
      price = snapshot['price'];
}