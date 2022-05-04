import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id = "";
  DateTime dateCreate = DateTime.now();
  String orderStatus = '', address = '';
  int totalPrice = 0;
  int itemsQty = 0;

  Order(
      {required this.id,
      required this.orderStatus,
      required this.totalPrice,
      required this.itemsQty,
      required this.address});

  Order.fromSnapShot(QueryDocumentSnapshot data)
      : id = data.id,
        dateCreate = DateTime.parse(data['dateCreate']),
        address = data['address'],
        orderStatus = data['orderStatus'],
        totalPrice = data['totalPrice'],
        itemsQty = data['itemsQty'];
}
