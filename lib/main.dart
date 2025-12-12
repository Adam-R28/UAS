import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  // 2. Fungsi utama untuk menjalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3. Widget utama aplikasi Anda
    return MaterialApp(
      title: 'Aplikasi Resep', // Judul aplikasi (terlihat di task manager, dll)
      debugShowCheckedModeBanner: false, // Menghilangkan banner "DEBUG"

      // 4. Mengatur tema global untuk konsistensi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Tema makanan cocok dengan hijau/oranye
          brightness:
              Brightness.light, // (Opsional: jika Anda menambahkan custom font)
        ),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          elevation: 0, // AppBar bersih tanpa bayangan
          backgroundColor: Colors.transparent, // AppBar transparan
          foregroundColor: Colors.black, // Teks dan ikon di AppBar jadi hitam
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 3, // Beri sedikit bayangan
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        useMaterial3: true,
      ),
      // 5. Menentukan halaman pertama yang dibuka
      home: const HomePage(),
    );
  }
}
