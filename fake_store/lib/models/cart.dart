
class Cart {
  int id;
  int userId;
  DateTime date;
  List<dynamic>? products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: json['products'],
    );
  }

}
