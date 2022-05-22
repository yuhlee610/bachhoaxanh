import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  DateTime dateCreate = DateTime.now();
  String orderStatus = '', address = '', id = "", discount = "";
  int itemsQty = 0, totalPrice = 0;

  Order(
      {required this.id,
      required this.orderStatus,
      required this.totalPrice,
      required this.itemsQty,
      required this.address,
      required this.discount});

  Order.fromSnapShot(QueryDocumentSnapshot data)
      : id = data.id,
        dateCreate = DateTime.parse(data['dateCreate']),
        address = data['address'],
        orderStatus = data['orderStatus'],
        totalPrice = data['totalPrice'],
        discount = data['discount'],
        itemsQty = data['itemsQty'];
}
