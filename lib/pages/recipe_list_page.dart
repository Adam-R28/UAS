import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'recipe_detail_page.dart';

class RecipeListPage extends StatefulWidget {
  final String categoryName; // Kita pakai nama kategori untuk API TheMealDB

  const RecipeListPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    // Panggil Service untuk ambil data berdasarkan kategori
    _recipesFuture = _recipeService.getRecipesByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          // 1. Loading State [cite: 127]
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } 
          // 2. Error State [cite: 128]
          else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } 
          // 3. Data Kosong
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada resep ditemukan."));
          }

          // 4. Success State [cite: 128]
          final recipes = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: recipes.length,
            itemBuilder: (ctx, index) {
              final recipe = recipes[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network( // PENTING: Pakai Network, bukan Asset
                      recipe.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Icon(Icons.broken_image),
                    ),
                  ),
                  title: Text(
                    recipe.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("ID: ${recipe.id}"),
                  onTap: () {
                    // Navigasi ke Detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipeId: recipe.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}