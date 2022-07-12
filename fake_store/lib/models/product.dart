class Product {
  int id;
  String title;
  double price;
  String description;
  String image;
  String category;

  Product(
      {
      required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.category}
  );

  factory Product.fromJson(Map<String, dynamic> item) {
    return Product(
        id: item['id'],
        title: item['title'],
        price: item['price'],
        description: item['description'],
        image: item['image'],
        category: item['category']);
  }
}
