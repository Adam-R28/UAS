// lib/services/recipe_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/recipe.dart';

class RecipeService {
  // Base URL TheMealDB
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // 1. Mengambil Daftar Kategori
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categories'];
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat kategori');
    }
  }

  // 2. Mengambil Daftar Resep berdasarkan Kategori
  Future<List<Recipe>> getRecipesByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$categoryName'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['meals'];
      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat resep');
    }
  }

  // 3. Mengambil Detail Resep (Bahan & Langkah) berdasarkan ID
  Future<Recipe> getRecipeDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List meals = data['meals'];
      if (meals.isNotEmpty) {
        return Recipe.fromJson(meals[0]);
      }
      throw Exception('Resep tidak ditemukan');
    } else {
      throw Exception('Gagal memuat detail resep');
    }
  }

  // 4. Fitur Pencarian (Search)
  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // API ini mengembalikan null pada 'meals' jika tidak ditemukan
      if (data['meals'] == null) return [];

      final List recipes = data['meals'];
      return recipes.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mencari resep');
    }
  }
}