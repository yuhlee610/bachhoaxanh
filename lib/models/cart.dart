class Cart {
  int quantity = 0, price = 0, amount = 0;
  String image, name, subcategory, id;

  Cart(
      {required this.id,
        required this.amount,
      required this.quantity,
      required this.price,
      required this.image,
      required this.name,
      required this.subcategory});

  Cart.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        image = map['image'],
        name = map['name'],
        subcategory = map['subcategory'],
        quantity = map['quantity'],
        amount = map['amount'],
        price = map['price'];
}
