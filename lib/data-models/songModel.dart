class CustomSong {
  int id;
  String artist;
  String title;
  String album;
  int albumId;
  int duration;
  String uri;
  String albumArt;

  CustomSong(
      {this.id,
      this.artist,
      this.title,
      this.album,
      this.albumId,
      this.duration,
      this.uri,
      this.albumArt});
  CustomSong.fromMap(Map m) {
    id = m["id"];
    artist = m["artist"];
    title = m["title"];
    album = m["album"];
    albumId = m["albumId"];
    duration = m["duration"];
    uri = m["uri"];
    albumArt = m["albumArt"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'artist': artist,
        'title': title,
        'album': album,
        'albumId': albumId,
        'duration': duration,
        'uri': uri,
        'albumArt': albumArt,
      };

  CustomSong.fromJson(dynamic m)
      : id = m.id,
        artist = m.artist,
        title = m.title,
        album = m.album,
        albumId = m.albumId,
        duration = m.duration,
        uri = m.uri,
        albumArt = m.albumArt;
}
