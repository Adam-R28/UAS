import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart'; // Import Service
import 'recipe_list_page.dart';
import 'recipe_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RecipeService _recipeService = RecipeService(); // Inisialisasi Service
  late Future<List<Category>> _categoriesFuture;
  late Future<List<Recipe>> _randomRecipesFuture; // Kita pakai search '' untuk default list

  // Controller untuk pencarian
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _recipeService.getCategories();
    // Mengambil resep default (misal pencarian kosong atau huruf 'b')
    _randomRecipesFuture = _recipeService.searchRecipes('b');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi pencarian
  void _performSearch() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _randomRecipesFuture = _recipeService.searchRecipes(_searchController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ResepKita (UAS)', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Data Real-time API', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar yang berfungsi
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari resep (e.g. Steak, Cake)...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _performSearch,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onSubmitted: (_) => _performSearch(),
              ),
            ),

            // 2. Kategori dari API
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Kategori", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),

            // Implementasi FutureBuilder untuk Kategori [cite: 129]
            FutureBuilder<List<Category>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Loading State
                } else if (snapshot.hasError) {
                  return Center(child: Text("Gagal memuat kategori")); // Error State
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Kategori kosong"));
                }

                return Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      final category = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeListPage(
                                categoryName: category.name, // TheMealDB butuh nama kategori, bukan ID
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(category.imageUrl),
                              ),
                              SizedBox(height: 5),
                              Text(category.name, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            // 3. Hasil Resep (Populer/Search)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Daftar Resep", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

            FutureBuilder<List<Recipe>>(
              future: _randomRecipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Resep tidak ditemukan"));
                }

                return ListView.builder(
                  shrinkWrap: true, // Penting di dalam SingleChildScrollView
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) {
                    final recipe = snapshot.data![index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Image.network(recipe.imageUrl, width: 60, fit: BoxFit.cover),
                        title: Text(recipe.title),
                        onTap: () {
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
          ],
        ),
      ),
    );
  }
}