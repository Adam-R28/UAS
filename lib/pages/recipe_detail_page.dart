import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  // Inisialisasi Service
  final RecipeService _recipeService = RecipeService();
  
  // Variabel untuk menampung Future (proses pengambilan data)
  late Future<Recipe> _recipeDetailFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil API saat halaman pertama kali dibuka
    _recipeDetailFuture = _recipeService.getRecipeDetail(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar standar
      appBar: AppBar(
        title: Text('Detail Resep'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Fitur tambahan (opsional): Simpan favorit
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Fitur Favorit belum diimplementasikan")),
              );
            },
          ),
        ],
      ),
      
      // BODY: Menggunakan FutureBuilder untuk menangani data Async
      body: FutureBuilder<Recipe>(
        future: _recipeDetailFuture,
        builder: (context, snapshot) {
          
          // 1. STATE LOADING: Menampilkan loading spinner saat data diambil
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Sedang memuat detail resep..."),
                ],
              ),
            );
          }
          
          // 2. STATE ERROR: Menampilkan pesan jika gagal ambil data / tidak ada internet
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    "Gagal memuat data.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${snapshot.error}", // Menampilkan pesan error teknis
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Coba ambil data lagi
                        _recipeDetailFuture = _recipeService.getRecipeDetail(widget.recipeId);
                      });
                    },
                    child: Text("Coba Lagi"),
                  )
                ],
              ),
            );
          }
          
          // 3. STATE SUCCESS: Data berhasil diambil
          else if (snapshot.hasData) {
            final recipe = snapshot.data!;
            
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- GAMBAR UTAMA ---
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stackTrace) =>
                          Container(color: Colors.grey[300], child: Icon(Icons.broken_image, size: 50)),
                    ),
                  ),

                  // --- JUDUL & KATEGORI ---
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Chip(
                          label: Text(recipe.category),
                          backgroundColor: Colors.orange.shade100,
                          avatar: Icon(Icons.category, size: 16, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  
                  Divider(thickness: 1, height: 1),

                  // --- BAHAN-BAHAN (INGREDIENTS) ---
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bahan-Bahan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // Mapping list bahan menjadi widget
                        ...recipe.ingredients.map((ingredient) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, size: 18, color: Colors.green),
                                SizedBox(width: 8),
                                Expanded(child: Text(ingredient, style: TextStyle(fontSize: 16))),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  Divider(thickness: 8, color: Colors.grey[200]),

                  // --- LANGKAH PEMBUATAN (INSTRUCTIONS) ---
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instruksi Pembuatan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          recipe.instructions,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                ],
              ),
            );
          }
          
          // Default fallback (jarang terjadi)
          return Center(child: Text("Data tidak ditemukan"));
        },
      ),
    );
  }
}