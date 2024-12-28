
class Product {
  final String name;
  final String iconPath;
  final String slug;
  final String description;
  final double price;

  Product({
    required this.name,
    required this.iconPath,
    required this.slug,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        iconPath: json['image'],
        slug: json['slug'],
        description: json['description'],
        price: json['price']
    );
  }
}