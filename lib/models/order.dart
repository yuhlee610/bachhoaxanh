class Order {
  String transId = "";
  DateTime dateCreate = DateTime.now();
  String orderStatus = "";
  double totalPrice = 0;
  int itemsQty = 0;

  Order(
      {required this.transId,
      required this.orderStatus,
      required this.totalPrice,
      required this.itemsQty});
}
