import '../artists/artist.dart'; // w9-03

class Song {
  final String id;
  final String title;
  final String artistId; // w9-01
  final String imageUrl; // w9-01
  final Duration duration;
  final Artist? artist; // w9-03

  Song({
    required this.id,
    required this.title,
    required this.artistId, // w9-01
    required this.imageUrl, // w9-01
    required this.duration,
    this.artist, // w9-03
  });

  // w9-03
  Song copyWith({
    String? id,
    String? title,
    String? artistId,
    String? imageUrl,
    Duration? duration,
    Artist? artist,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      artist: artist ?? this.artist,
    );
  }

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artistId: $artistId, imageUrl: $imageUrl, duration: $duration, artist: $artist)'; // w9-03
  }
}
