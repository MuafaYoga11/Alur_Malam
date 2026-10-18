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

  factory Film.fromJson(Map<String, dynamic> json) {
    final List<dynamic> genres = json['genres'] ?? [];

    return Film(
      id: json['id'] as int,
      title: json['name'] ?? 'Tanpa Judul',
      genre: genres.isNotEmpty
          ? genres.join(', ')
          : 'Genre tidak tersedia',
      posterUrl: json['image']?['medium'],
    );
  }
}