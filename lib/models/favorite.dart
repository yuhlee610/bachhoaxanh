class Favorite {
  String id, image, name, subcategory;
  int price, amount, sale;

  Favorite(
      {required this.id,
      required this.image,
      required this.name,
      required this.subcategory,
      required this.amount,
      required this.price,
      required this.sale});

  Favorite.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        image = map['image'],
        name = map['name'],
        subcategory = map['subcategory'],
        amount = map['amount'],
        sale = map['sale'],
        price = map['price'];
}
