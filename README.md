# UTS

# 🎬 Alur Malam

Aplikasi katalog serial sederhana yang dibuat menggunakan Flutter dan Dart. Aplikasi mengambil data serial televisi secara langsung dari TVMaze API, kemudian mengolah dan menampilkannya pada antarmuka aplikasi.

Project ini dibuat sebagai contoh pembelajaran untuk memahami bagaimana aplikasi Flutter dapat mengambil data dari API, mengolah JSON menjadi object Dart, dan menampilkan data tersebut secara dinamis pada GUI.

## 📱 Tampilan Aplikasi

Berikut merupakan tampilan aplikasi Alur Malam yang dijalankan menggunakan emulator Android Pixel 10.

[Tampilan Aplikasi Alur Malam](./Screenshot_20261022_205004.png)


Aplikasi menggunakan desain antarmuka dengan kombinasi warna burgundy, oranye, dan ivory. Katalog menampilkan poster serial, judul, genre, serta tombol untuk menandai serial yang dipilih.

Aplikasi menampilkan:

- 🎬 Judul serial
- 🏷️ Genre serial
- 🖼️ Poster serial
- ➕ Tombol untuk menambahkan serial ke pilihan
- ✓ Indikator serial yang telah dipilih
- 🌐 Data serial yang diperoleh langsung dari TVMaze API

## 🚀 Teknologi yang Digunakan

| Teknologi | Kegunaan |
|---|---|
| Flutter | Framework untuk membangun aplikasi |
| Dart | Bahasa pemrograman |
| TVMaze API | Menyediakan data serial televisi |
| http | Mengirim HTTP request ke API |
| jsonDecode() | Mengubah response JSON menjadi data Dart |
| StatefulWidget | Mengelola perubahan state aplikasi |
| setState() | Memperbarui tampilan ketika serial dipilih |

## 🔄 Alur Kerja Aplikasi

Data serial diperoleh melalui beberapa tahap:

```text
┌─────────────────┐
│   Flutter App   │
└────────┬────────┘
         │
         │ HTTP GET
         ▼
┌─────────────────┐
│   TVMaze API    │
└────────┬────────┘
         │
         │ JSON Response
         ▼
┌─────────────────┐
│   jsonDecode()  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Dart Model   │
│      Film       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    List<Film>   │
│   Maksimal 5    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│       GUI       │
│   Alur Malam    │
└─────────────────┘
```

Data dari TVMaze diubah dari JSON menjadi object Dart sebelum digunakan oleh bagian antarmuka aplikasi.

## 📂 Struktur Project

Struktur utama project dibuat berdasarkan fungsi masing-masing file:

```text
alur_malam/
│
├── android/
├── ios/
│
├── fonts/
│   ├── Inter_18pt-Regular.ttf
│   ├── Natasha.ttf
│   └── Ndot57Caps-Regular.otf
│
├── lib/
│   ├── main.dart
│   │
│   ├── model/
│   │   └── film.dart
│   │
│   └── service/
│       └── tvmaze_service.dart
│
├── Screenshot_20261022_205004.png
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

### main.dart

Menjadi titik awal aplikasi dan menjalankan `MyApp`.

File ini berisi:

- Konfigurasi warna aplikasi
- Halaman utama
- Header aplikasi
- Komponen kartu serial
- Pengelolaan serial yang dipilih
- Tampilan loading dan error

### model/film.dart

Berisi model Dart untuk merepresentasikan data serial:

- `Film` menyimpan informasi serial.
- `id` digunakan sebagai identitas serial.
- `title` menyimpan judul serial.
- `genre` menyimpan genre serial.
- `posterUrl` menyimpan URL gambar poster jika tersedia.

### service/tvmaze_service.dart

Menangani komunikasi dengan API TVMaze, mulai dari mengirim HTTP request sampai mengubah response JSON menjadi object Film.

## 🌐 API TVMaze

Aplikasi menggunakan TVMaze API untuk memperoleh data serial televisi.

Endpoint yang digunakan:

https://api.tvmaze.com/shows

Data yang digunakan oleh aplikasi antara lain:

```text
id
name
genres
image.medium
```

Data tersebut digunakan untuk menampilkan identitas serial, genre, dan gambar poster.

Aplikasi mengambil maksimal 5 serial pertama dari response API untuk ditampilkan pada katalog.

## 📦 Package

Project menggunakan package eksternal `http`.

### http

Digunakan untuk mengirim request ke API TVMaze.

```bash
flutter pub add http
```

## ⚙️ Persiapan Project

Pastikan Flutter SDK sudah terpasang pada komputer.

Clone repository:

```bash
git clone <URL_REPOSITORY>
```

Masuk ke folder project:

```bash
cd UTS
```

Install dependency:

```bash
flutter pub get
```

Periksa perangkat yang tersedia:

```bash
flutter devices
```

Kemudian jalankan aplikasi:

```bash
flutter run
```

## 🤖 Android Internet Permission

Karena aplikasi mengambil data dari internet, Android perlu diberikan permission untuk mengakses jaringan.

Tambahkan permission berikut pada:

`android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

Permission ditempatkan di dalam tag `<manifest>` dan di luar tag `<application>`.

## 🎯 Konsep yang Dipelajari

Project ini dapat digunakan untuk mempelajari beberapa konsep dasar pengembangan aplikasi Flutter:

- Widget dasar Flutter
- Column dan Row
- Custom widget
- HTTP request
- REST API
- JSON
- jsonDecode()
- Dart class model
- Future
- async dan await
- StatefulWidget
- setState()
- Pengolahan data secara dinamis dari server
- Penanganan loading dan error

## 🧩 Fitur Utama

### 🎬 Katalog Serial

Aplikasi mengambil data serial dari TVMaze dan menampilkan maksimal 5 serial pertama.

### 🏷️ Informasi Serial

Judul dan genre serial diperoleh langsung dari data API.

### 🖼️ Poster Serial

Aplikasi menampilkan poster serial jika tersedia. Jika gambar tidak dapat dimuat, area poster menggunakan placeholder abu-abu tanpa ikon tambahan.

### ➕ Pilihan Serial

Pengguna dapat menekan tombol tambah untuk menandai serial yang dipilih. Tombol akan berubah menjadi tanda centang.

## ⚠️ Penanganan Kondisi Data

Aplikasi menangani beberapa kondisi selama proses pengambilan data:

- Data sedang dimuat
- Request mengalami error
- Data serial tidak tersedia
- Gambar poster tidak dapat dimuat
- Pengguna mencoba kembali mengambil data setelah error

## 🛠️ Pengembangan Selanjutnya

Project ini dapat dikembangkan lebih lanjut, misalnya dengan:

- Menambahkan fitur pencarian serial.
- Menampilkan detail serial.
- Menambahkan kategori genre.
- Menambahkan fitur favorit dengan penyimpanan lokal.
- Menambahkan refresh data.
- Menambahkan desain responsif untuk berbagai ukuran layar.
- Menambahkan halaman detail serial.

## 📚 Tujuan Pembelajaran

Project ini dirancang sebagai contoh sederhana untuk memahami alur pengembangan aplikasi Flutter yang mengambil data dari API.

Pembelajaran dimulai dari GUI dengan data statis, kemudian berkembang menjadi aplikasi yang mengambil data aktual dari server:

```text
GUI Statis
    ↓
HTTP Request
    ↓
JSON
    ↓
Dart Model
    ↓
Future / async / await
    ↓
Data API
    ↓
GUI Dinamis
```

Setiap bagian dapat dipelajari secara bertahap sehingga konsep Flutter, API, JSON, dan pengolahan data asynchronous dapat dipahami melalui satu project yang utuh.

## 👨‍💻 Project

**Alur Malam**

Dibangun menggunakan:

Flutter + Dart + TVMaze API

