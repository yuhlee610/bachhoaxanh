import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/favorite.dart';
import '../models/product.dart';
import '../models/user.dart';

class FavoriteProvider with ChangeNotifier {
  List<Favorite> _favoriteList = [];

  List<Favorite> get favoriteList => _favoriteList;

  void fetchFavorite(String userId) {
    List<Favorite> fetchFavorite = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        fetchFavorite.add(new Favorite(
            id: element.id,
            image: element['image'],
            name: element['name'],
            subcategory: element['subcategory'],
            amount: element['amount'],
            price: element['price']));
      });

      _favoriteList = fetchFavorite;
      notifyListeners();
    });
  }

  void deleteFavorite(String userId, String productId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .doc(productId)
        .delete();
  }

  void updateFavorite(String userId, Product product) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .doc(product.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorite')
            .doc(product.id)
            .delete();
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorite')
            .doc(product.id)
            .set({
          'id': product.id,
          'name': product.name,
          'image': product.image[0],
          'price': product.price,
          'subcategory': product.subcategory,
          'amount': product.amount
        });
      }
    }).catchError((error) {
      print(error);
    });
  }
}
