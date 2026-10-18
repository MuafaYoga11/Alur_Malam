import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final String title;
  final String genre;

  const Film({
    required this.title,
    required this.genre,
  });
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
  // DATA FILM SEMENTARA
  final List<Film> films = const [
    Film(title: 'JUDUL', genre: 'genre'),
    Film(title: 'JUDUL', genre: 'genre'),
    Film(title: 'JUDUL', genre: 'genre'),
    Film(title: 'JUDUL', genre: 'genre'),
    Film(title: 'JUDUL', genre: 'genre'),
  ];

  // FILM YANG DIPILIH
  final Set<int> selectedFilms = {};

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
                  child: ListView.builder(
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
                          isSelected: selectedFilms.contains(index),
                          onAdd: () {
                            setState(() {
                              if (selectedFilms.contains(index)) {
                                selectedFilms.remove(index);
                              } else {
                                selectedFilms.add(index);
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
