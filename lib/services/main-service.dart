import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flexplay/data-models/songModel.dart';
import 'package:flexplay/services/songs.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAppProvider with ChangeNotifier, SongService {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();
  // double _playtimer = 0.0;
  double _songDuration = 40.0;
  int _currentSongIndex = 0;
  PublishSubject<double> _playtimer = PublishSubject();
  PublishSubject<CustomSong> _currentlyPlaying = PublishSubject();
  // CustomSong _currentlyPlaying;

  AssetsAudioPlayer get player {
    return _player;
  }

  PublishSubject<double> get playtimer {
    return _playtimer;
  }

  PublishSubject<CustomSong> get currentlyPlaying {
    return _currentlyPlaying;
  }

  // double get playtimer {
  //   return _playtimer;
  // }

  double get songDuration {
    return _songDuration;
  }

  Future<int> get currentSongIndex async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentSongIndex = prefs.getInt('currentSongIndex');
    return _currentSongIndex;
  }

  void listenersDurationandTrack() {
    player.currentPosition.listen((event) {
      notifyListeners();
      // print("_player.currentPosition: $event");
      _playtimer.add(event.abs().inSeconds.toDouble());
      // basic maths
      // print('in seconds $_playtimer');
      notifyListeners();

      // print('playing ${event.assetAudio}');
    });
    //Listen to the current playing song
    player.current.listen((playingAudio) {
      notifyListeners();
      final asset = playingAudio.audio;
      // print('playing $asset');
      var unformattedSongDuration = asset.duration.abs().inSeconds.toString();
      _songDuration = double.parse(unformattedSongDuration);
      notifyListeners();

      // print('duration $_songDuration');
      // print('duration ${_songDuration.runtimeType}');
    });
  }

  setCurrrentlyPlaying(song, index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentlyPlaying', json.encode(song.toJson()));
    print('saved song');
    await prefs.setInt('currentSongIndex', index);
    _currentlyPlaying.add(song);
    // _currentlyPlaying = song;
    _currentSongIndex = index;
    notifyListeners();
  }

  void playNext(index) {
    // check if its the last track
    if (index >= totalSongs - 1) {
      player.open(
        Audio.file(localSongs[0].uri),
        showNotification: true,
      );

      setCurrrentlyPlaying(localSongs[0], 0);
    } else {
      player.open(
        Audio.file(localSongs[index + 1].uri),
        showNotification: true,
      );
      setCurrrentlyPlaying(localSongs[index + 1], index + 1);
    }
  }

  void playPrevious(index) {
    print('initial index $index');
    if (index <= 0) {
      player.open(
        Audio.file(localSongs[totalSongs - 1].uri),
        showNotification: true,
      );
      setCurrrentlyPlaying(localSongs[totalSongs - 1], totalSongs - 1);
    } else {
      player.open(
        Audio.file(localSongs[index - 1].uri),
        showNotification: true,
      );
      print('playing ${index - 1}');
      setCurrrentlyPlaying(localSongs[index - 1], index - 1);
    }

    // }
  }
}
