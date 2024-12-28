class Category {
  final String name;
  final String slug;
  final String iconPath;

  Category({required this.name, required this.iconPath, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      iconPath: json['icon'],
      slug: json['slug']
    );
  }
}
