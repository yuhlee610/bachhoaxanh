import 'package:bachhoaxanh/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailProvider with ChangeNotifier {
  List<Cart> _orderDetail = [];


  List<Cart> get orderDetail => _orderDetail;

  void getDetailOrder(String userId, String orderId) {
    List<Cart> orderDetailTmp = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .collection('orderDetail')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        orderDetailTmp.add(Cart.fromSnapShot(element));
      });
      _orderDetail = orderDetailTmp;
      notifyListeners();
    });
  }
}
