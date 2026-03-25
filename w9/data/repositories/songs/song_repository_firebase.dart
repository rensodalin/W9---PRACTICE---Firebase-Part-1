import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https("week-8-practice-b5334-default-rtdb.firebaseio.com",'songs.json');

  // w9-03: Cache mechanism for repositories
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs() async {
    // w9-03
    if (_cachedSongs != null) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      // w9-01
      Map<String, dynamic> songJson = json.decode(response.body);
      List<Song> songs = [];
      songJson.forEach((key, value) {
        value[SongDto.idKey] = key;
        songs.add(SongDto.fromJson(value));
      });
      // w9-03
      _cachedSongs = songs;
      return songs;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async { return null; }
}
