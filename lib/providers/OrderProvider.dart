import 'package:bachhoaxanh/constant.dart';
import 'package:bachhoaxanh/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void getOrders(String userId) {
    List<Order> ordersTmp = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((element) {
            ordersTmp.add(Order.fromSnapShot(element));
          });
          _orders = ordersTmp;
          notifyListeners();
    });
  }

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
          'sale': element.sale,
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
