import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https("week-8-practice-b5334-default-rtdb.firebaseio.com", 'artists.json');

  // w9-03: Cache mechanism
  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtists() async {
    // w9-03
    if (_cachedArtists != null) {
      return _cachedArtists!;
    }

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      if (response.body == "null") return [];
      Map<String, dynamic> artistsJson = json.decode(response.body);
      List<Artist> artists = [];
      artistsJson.forEach((key, value) {
        value[ArtistDto.idKey] = key;
        artists.add(ArtistDto.fromJson(value));
      });
      // w9-03
      _cachedArtists = artists;
      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    // optional implementation
    return null;
  }
}
