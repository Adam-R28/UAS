class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});

  // Factory method untuk parsing JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      name: json['strCategory'],
      imageUrl: json['strCategoryThumb'],
    );
  }
}