import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/artists/artist_repository.dart'; // w9-03
import '../../../../model/artists/artist.dart'; // w9-03
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository; // w9-03
  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository, 
    required this.artistRepository, // w9-03
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      
      // w9-03
      // Join songs with artists in the ViewModel
      try {
        List<Artist> artists = await artistRepository.fetchArtists();
        for (int i = 0; i < songs.length; i++) {
          try {
            Artist artist = artists.firstWhere((a) => a.id == songs[i].artistId);
            songs[i] = songs[i].copyWith(artist: artist);
          } catch (e) {
            // artist not found for song
          }
        }
      } catch (e) { // fetching artists failed, but we still have songs
        print("Failed to fetch artists for songs $e");
      }

      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
