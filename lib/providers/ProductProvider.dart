import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  var _products = [];
  var _bestSeller = [];
  var _hotDeals = [];

  bool _allLoaded = false;
  String _latestProd = '';

  get hotDeals => _hotDeals;

  get bestSeller => _bestSeller;

  get products => _products;

  set products(value) {
    _products = value;
  }

  void fetchHotDeals() {
    var hotdeals = [];
    FirebaseFirestore.instance
        .collection('products')
        .where('sale', isGreaterThan: 0)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var data = element.data();
        hotdeals.add(Product.fromMap(data));
      });
      _hotDeals = hotdeals;
      notifyListeners();
    });
  }

  void fetchBestSeller() {
    var bestSeller = [];
    FirebaseFirestore.instance
        .collection('products')
        .orderBy('sold')
        .limit(10)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var data = element.data();
        bestSeller.add(Product.fromMap(data));
      });
    });
    _bestSeller = bestSeller;
  }

  void updateProducts(
      QuerySnapshot<Map<String, dynamic>> querySnapshot, bool shouldRenew) {
    List<Product> productList = [];
    querySnapshot.docs.forEach((element) {
      var data = element.data();
      productList.add(Product.fromMap(data));
    });
    if (productList.isNotEmpty) {
      _latestProd = querySnapshot.docs[querySnapshot.docs.length - 1]['name'];
    }
    if (shouldRenew) {
      _products = productList;
    } else {
      _products = _products + productList;
    }
    _allLoaded = productList.isEmpty;
    notifyListeners();
  }

  void fetchProducts(String subcategory, bool shouldRenew) {
    if (_allLoaded && !shouldRenew) {
      return;
    }
    if (shouldRenew) {
      _latestProd = '';
    }
    try {
      if (subcategory == 'All') {
        FirebaseFirestore.instance
            .collection('products')
            .orderBy('name')
            .startAfter([_latestProd])
            .limit(2)
            .get()
            .then((querySnapshot) {
              updateProducts(querySnapshot, shouldRenew);
            });
      } else {
        FirebaseFirestore.instance
            .collection('products')
            .where('subcategory', isEqualTo: subcategory)
            .orderBy('name')
            .startAfter([_latestProd])
            .limit(2)
            .get()
            .then((querySnapshot) {
              updateProducts(querySnapshot, shouldRenew);
            });
      }
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }
}
