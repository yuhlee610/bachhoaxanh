import 'package:bachhoaxanh/models/order.dart';

import 'cart.dart';

class OrderDetail {
  late Order order;
  late List<Cart> cartList;
  late String address;

  OrderDetail({required this.order, required this.cartList, required this.address});
}