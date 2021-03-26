import 'package:flexplay/data-models/songModel.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class SongService with ChangeNotifier {
  MusicFinder audioPlayer;
  List<CustomSong> _localSongs = [];

  List<CustomSong> get localSongs {
    return List.from(_localSongs);
  }

  int get totalSongs {
    return _localSongs.length;
  }

  Future getlocalSongs() async {
    try {
      print('fetching songs');
      audioPlayer = new MusicFinder();
      var results = await MusicFinder.allSongs();
      print('all songs $results');
      results.forEach((item) {
        var serialized = CustomSong.fromJson(item);
        var _customItems = CustomSong(
            id: serialized.id,
            artist: serialized.artist,
            title: serialized.title,
            album: serialized.album,
            albumId: serialized.albumId,
            duration: serialized.duration,
            uri: serialized.uri,
            albumArt: serialized.albumArt);

        _localSongs.add(_customItems);
      });
      print("new songs $_localSongs");
      // _localSongs =
      notifyListeners();
      return _localSongs;
    } catch (error) {
      print('error $error');
    }
  }
}
