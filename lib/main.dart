import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// WARNA APLIKASI
const Color burgundy = Color(0xFF800020);
const Color goldenOrange = Color(0xFFF19B03);
const Color ivory = Color(0xFFFFFFF0);
const Color posterPlaceholder = Color(0xFFD9D9D9);
const Color blackColor = Color(0xFF1F1F1F);

// MODEL FILM
class Film {
  final int id;
  final String title;
  final String genre;
  final String? posterUrl;

  const Film({
    required this.id,
    required this.title,
    required this.genre,
    this.posterUrl,
  });

  // Mengubah data JSON TVMaze menjadi objek Film
  factory Film.fromJson(Map<String, dynamic> json) {
    final List<dynamic> genres = json['genres'] ?? [];
    final image = json['image'];

    return Film(
      id: json['id'] as int,
      title: json['name'] ?? 'Tanpa Judul',
      genre: genres.isNotEmpty
          ? genres.join(', ')
          : 'Genre tidak tersedia',
      posterUrl: image?['medium'] as String?,
    );
  }
}

// SERVICE API TVMAZE
class TvMazeService {
  static Future<List<Film>> getShows() async {
    final url = Uri.parse('https://api.tvmaze.com/shows');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      // Hanya mengambil 5 serial pertama
      return data
          .take(5)
          .map((item) => Film.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal mengambil data dari TVMaze');
    }
  }
}

// ROOT APLIKASI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alur Malam',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ivory,
      ),
      home: const HomePage(),
    );
  }
}

// HALAMAN UTAMA
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DATA FILM DARI TVMAZE
  List<Film> films = [];

  // FILM YANG DIPILIH
  final Set<int> selectedFilms = {};

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadFilms();
  }

  // MENGAMBIL DATA SERIAL
  Future<void> loadFilms() async {
    try {
      final result = await TvMazeService.getShows();

      if (!mounted) return;

      setState(() {
        films = result;
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Gagal memuat serial. Periksa koneksi internet.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // STATUS BAR ATAS
        statusBarColor: burgundy,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,

        // NAVIGASI BAWAH HP
        systemNavigationBarColor: ivory,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: ivory,
      ),
      child: Scaffold(
        backgroundColor: burgundy,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // HEADER BURGUNDY
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  color: burgundy,
                  child: const HeaderSection(),
                ),
              ),

              // PANEL KATALOG IVORY
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ivory,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: burgundy,
                    ),
                  )
                      : errorMessage != null
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            loadFilms();
                          },
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      35,
                      24,
                      24,
                    ),
                    itemCount: films.length,
                    itemBuilder: (context, index) {
                      final film = films[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 32,
                        ),
                        child: FilmCard(
                          film: film,
                          isSelected:
                          selectedFilms.contains(film.id),
                          onAdd: () {
                            setState(() {
                              if (selectedFilms
                                  .contains(film.id)) {
                                selectedFilms.remove(film.id);
                              } else {
                                selectedFilms.add(film.id);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ALUR MALAM
          const Text(
            'ALUR MALAM',
            style: TextStyle(
              fontFamily: 'Natasha',
              fontSize: 24,
              color: goldenOrange,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 24),

          // WELCOME
          const Text(
            'WELCOME',
            style: TextStyle(
              fontFamily: 'Ndot57Caps',
              fontSize: 48,
              color: goldenOrange,
            ),
          ),
        ],
      ),
    );
  }
}

// KARTU FILM
class FilmCard extends StatelessWidget {
  final Film film;
  final bool isSelected;
  final VoidCallback onAdd;

  const FilmCard({
    super.key,
    required this.film,
    required this.isSelected,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 296,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // POSTER FILM
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 296,
              child: Stack(
                children: [
                  // LATAR POSTER ORANYE
                  Container(
                    height: 260,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: goldenOrange,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),

                  // TEMPAT GAMBAR POSTER
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 246,
                      decoration: BoxDecoration(
                        color: posterPlaceholder,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: film.posterUrl != null
                            ? Image.network(
                          film.posterUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (
                              context,
                              error,
                              stackTrace,
                              ) {
                            return const ColoredBox(
                              color: posterPlaceholder,
                            );
                          },
                        )
                            : const ColoredBox(
                          color: posterPlaceholder,
                        ),
                      ),
                    ),
                  ),

                  // IKON TAMBAH
                  Positioned(
                    top: 12,
                    right: 12,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isSelected ? Icons.check : Icons.add,
                          size: 24,
                          color: blackColor,
                        ),
                        onPressed: onAdd,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 18),

          // JUDUL DAN GENRE
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // JUDUL FILM
                  Text(
                    film.title,
                    style: const TextStyle(
                      fontFamily: 'Natasha',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // GENRE FILM
                  Text(
                    film.genre,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
