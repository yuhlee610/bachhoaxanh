import 'package:bachhoaxanh/models/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/cart.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  List<Cart> _cartList = [];

  List<Cart> get cartList => _cartList;

  void removeCartItem(String cartId, String userId) {
    int index = cartList.indexWhere((element) => element.id == cartId);
    _cartList.removeAt(index);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartId)
        .delete();

    notifyListeners();
  }

  void increaseQty(String cartId, String userId) {
    int index = cartList.indexWhere((element) => element.id == cartId);
    if (cartList[index].quantity < cartList[index].amount) {
      cartList[index].quantity++;

      FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartId)
        .update({'quantity': cartList[index].quantity});

      notifyListeners();
    }
  }

  void decreaseQty(String cartId, String userId) {
    int index = cartList.indexWhere((element) => element.id == cartId);
    if (cartList[index].quantity > 1) {
      cartList[index].quantity--;

      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartId)
          .update({'quantity': cartList[index].quantity});

      notifyListeners();
    }
  }

  void fetchCart(String userId) {
    List<Cart> cartList = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        cartList.add(new Cart(
            id: element['id'],
            amount: element['amount'],
            quantity: element['quantity'],
            price: element['price'],
            image: element['image'],
            name: element['name'],
            sale: element['sale'],
            subcategory: element['subcategory']));
      });

      _cartList = cartList;
      notifyListeners();
    });
  }

  void addToCartFromFavor(List<Favorite> favoriteList, String userId, int quantity) {
    favoriteList.forEach((element) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(element.id)
          .set({
        'id': element.id,
        'name': element.name,
        'image': element.image,
        'price': element.price,
        'subcategory': element.subcategory,
        'amount': element.amount,
        'sale': element.sale,
        'quantity': quantity
      });
    });
  }

  void addToCartFromDetail(Product product, String userId, int quantity) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(product.id)
        .set({
      'id': product.id,
      'name': product.name,
      'image': product.image[0],
      'price': product.price,
      'subcategory': product.subcategory,
      'amount': product.amount,
      'sale': product.sale,
      'quantity': quantity
    });
  }

  void clearCart(List<Cart> cartList, String userId) {
    cartList.forEach((element) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(element.id)
          .delete();
    });
    _cartList = [];
    notifyListeners();
  }
}
