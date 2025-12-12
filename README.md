# 🍳 ResepKita - Aplikasi Katalog Resep (UAS Mobile Programming)

**ResepKita** adalah aplikasi mobile berbasis Flutter yang menyediakan informasi resep masakan dari berbagai negara. Proyek ini dikembangkan sebagai pemenuhan **Ujian Akhir Semester (UAS)** mata kuliah Mobile Programming.

Aplikasi ini telah bermigrasi dari penggunaan data statis (dummy) menjadi **data dinamis** yang diambil secara *real-time* dari server menggunakan **RESTful API**.

## 📱 Fitur Utama

Sesuai dengan ketentuan UAS, aplikasi ini memiliki fitur-fitur teknis berikut:

* **Integrasi REST API:** Mengambil data kategori dan resep dari [TheMealDB API](https://www.themealdb.com/api.php).
* **Pencarian Resep (Search):** Fitur pencarian server-side untuk menemukan resep spesifik.
* **Asynchronous UI:** Penanganan *state* aplikasi yang responsif:
    * ✅ **Loading State:** Menampilkan indikator saat data sedang diambil.
    * ✅ **Success State:** Menampilkan data dalam Grid/List yang rapi.
    * ✅ **Error State:** Menampilkan pesan error yang ramah pengguna jika koneksi gagal.
* **Detail Resep Lengkap:** Menampilkan gambar, bahan-bahan (*ingredients*), dan langkah pembuatan (*instructions*).
* **Clean Code:** Pemisahan logika bisnis (Service) dan antarmuka (UI).

## 🛠️ Teknologi yang Digunakan

* **Framework:** Flutter & Dart
* **Networking:** Package `http`
* **API Provider:** [TheMealDB](https://www.themealdb.com/api.php) (Free Public API)
* **IDE:** VS Code / Android Studio

## 📸 Tangkapan Layar (Screenshots)

| Halaman Beranda (Loading) | Halaman Beranda (Data API) | Hasil Pencarian |
|:-------------------------:|:--------------------------:|:---------------:|
| *(Tempel Link Gambar 1)* |  *(Tempel Link Gambar 2)* | *(Tempel Link Gambar 3)* |

| Detail Resep | Penanganan Error (Offline) |
|:------------:|:--------------------------:|
| *(Tempel Link Gambar 4)* | *(Tempel Link Gambar 5)* |

> *Catatan: Gambar di atas menunjukkan aplikasi berjalan dengan data real-time.*

## 📂 Struktur Proyek
