class Favorite {
  String id, image, name, subcategory;
  int price, amount;

  Favorite(
      {required this.id,
      required this.image,
      required this.name,
      required this.subcategory,
      required this.amount,
      required this.price});

  Favorite.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        image = map['image'],
        name = map['name'],
        subcategory = map['subcategory'],
        amount = map['amount'],
        price = map['price'];
}
