import 'package:bachhoaxanh/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class OrderProvider with ChangeNotifier {
  void createOrder(
      List<Cart> cartList, String userId, int total, String address) {
    int quantity = 0;
    cartList.forEach((element) {
      quantity = quantity + element.quantity;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .add({
      'totalPrice': total,
      'itemsQty': quantity,
      'dateCreate': new DateTime.now().toString(),
      'orderStatus': packingStatus,
      'address': address
    }).then((orderRef) {
      cartList.forEach((element) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('orders')
            .doc(orderRef.id)
            .collection('orderDetail')
            .add({
          'id': element.id,
          'name': element.name,
          'image': element.image,
          'price': element.price,
          'subcategory': element.subcategory,
          'amount': element.amount,
          'quantity': element.quantity
        });
      });
    });

    cartList.forEach((element) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(element.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        FirebaseFirestore.instance
            .collection('products')
            .doc(element.id)
            .update({
          'sold': documentSnapshot['sold'] + element.quantity,
          'amount': documentSnapshot['amount'] - element.quantity
        });
      });
    });
  }
}
