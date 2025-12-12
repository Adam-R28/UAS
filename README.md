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
/lib 
├── /models # Model data (JSON Serialization) 
│ 
├── category.dart 
│ 
└── recipe.dart
├── /pages # Tampilan Antarmuka (UI) 
│ 
├── home_page.dart
│ 
├── recipe_list_page.dart
│ 
└── recipe_detail_page.dart 
├── /services # Logika HTTP Request
│ 
└── recipe_service.dart
└── main.dart
# Entry point & Tema
## 🚀 Cara Menjalankan Aplikasi

Ikuti langkah ini untuk mencoba aplikasi di mesin lokal Anda:

1.  **Clone Repositori ini**
    ```bash
    git clone [https://github.com/username-anda/nama-repo.git](https://github.com/username-anda/nama-repo.git)
    ```

2.  **Masuk ke direktori proyek**
    ```bash
    cd nama-repo
    ```

3.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

4.  **Jalankan Aplikasi**
    Pastikan emulator atau device fisik sudah terhubung dan memiliki koneksi internet.
    ```bash
    flutter run
    ```

## 👤 Profil Mahasiswa

* **Nama:** [Tulis Nama Lengkap Anda]
* **NIM:** [Tulis NIM Anda]
* **Kelas:** [Tulis Kelas Anda]
* **Kampus:** UIN Maulana Malik Ibrahim Malang

---
*Dibuat dengan  menggunakan Flutter*
