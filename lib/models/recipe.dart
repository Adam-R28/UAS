class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.category = '',
    this.instructions = '',
    this.ingredients = const [],
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Logika untuk mengambil bahan-bahan (TheMealDB menyediakan sampai 20 slot)
    List<String> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add('$measure $ingredient');
      }
    }

    return Recipe(
      id: json['idMeal'],
      title: json['strMeal'],
      imageUrl: json['strMealThumb'],
      category: json['strCategory'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredientsList,
    );
  }
}