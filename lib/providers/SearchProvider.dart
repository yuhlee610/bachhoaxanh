import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class SearchProvider with ChangeNotifier {
  var _products = [];

  get products => _products;

  void fetchSearchProducts(String search) {
    var product = [];
    FirebaseFirestore.instance
        .collection('products')
        .where('name', isEqualTo: search)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var data = element.data();
        product.add(Product.fromMap(data));
      });
      _products = product;
      notifyListeners();
    });
  }
}