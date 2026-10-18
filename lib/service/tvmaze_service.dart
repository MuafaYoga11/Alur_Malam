import 'dart:convert';
import 'package:http/http.dart' as http;

class TvMazeService {
  static Future<List<dynamic>> getShows() async {
    final url = Uri.parse('https://api.tvmaze.com/shows');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Gagal mengambil data TVMaze');
    }
  }
}