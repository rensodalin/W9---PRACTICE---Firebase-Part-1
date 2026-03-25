    import '../../model/songs/song.dart';

class SongDto {
  static const String idKey = 'id';
  // w9-01
  static const String titleKey = 'title';
  static const String artistIdKey = 'artistId';
  static const String durationKey = 'duration';   // in ms
  static const String imageUrlKey = 'imageUrl';

  static Song fromJson(Map<String, dynamic> json) {
    // w9-01
    assert(json[idKey] is String);
    assert(json[titleKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[imageUrlKey] is String);
    assert(json[durationKey] is int);

    return Song(
      id: json[idKey],
      title: json[titleKey],
      // w9-01
      artistId: json[artistIdKey],
      imageUrl: json[imageUrlKey],
      duration: Duration(milliseconds: json[durationKey]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      idKey: song.id,
      titleKey: song.title,
      // w9-01
      artistIdKey: song.artistId,
      imageUrlKey: song.imageUrl,
      durationKey: song.duration.inMilliseconds,
    };
  }
}
