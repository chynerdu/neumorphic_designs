import 'dart:io';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flexplay/data-models/songModel.dart';
import 'package:flexplay/services/main-service.dart';
import 'package:flexplay/utils/colors.dart';
import 'package:flexplay/utils/style.dart';
import 'package:flexplay/widgets/player_controls.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class AllTracks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllTracksState();
  }
}

class AllTracksState extends State<AllTracks> {
  initState() {
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    // provider.player.currentPosition.listen((event) {
    //   print("_player.currentPosition: $event");
    //   // print('playing ${event.assetAudio}');
    // });
    // //Listen to the current playing song
    // provider.player.current.listen((playingAudio) {
    //   final asset = playingAudio.audio;
    //   print('playing $asset');
    // });
    // print('${provider.player.getCurrentAudioAlbum}');
    super.initState();
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    return Stack(
      children: [
        // SingleChildScrollView(
        //     child:

        Container(
            child: ListView.builder(
          itemCount: provider.localSongs.length,
          itemBuilder: (BuildContext contex, index) {
            final track = provider.localSongs[index];
            return mediaItem(track, index);
          },
        )),

        // ),
        Positioned(bottom: 0, child: PlayerControls())
      ],
    );
  }

  void play(CustomSong song, index) {
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    // print('playing');
    // final assetsAudioPlayer = AssetsAudioPlayer();
    // provider.player.playOrPause();
    // final assetsAudioPlayer = AssetsAudioPlayer();
    provider.player.open(
      Audio.file(song.uri),
      showNotification: true,
    );

    provider.setCurrrentlyPlaying(song, index);
    // }
  }

  // void getMetaInfo(songUri) async {
  //   var retriever = new MetadataRetriever();
  //   await retriever.setFile(new File(songUri));
  //   Metadata metadata = await retriever.metadata;
  //   print('track name ${metadata.trackName}');
  // }

  Widget mediaItem(CustomSong song, int index) {
    ImageProvider imageProvider;
    if (song.albumArt != null) {
      String imagePath = song.albumArt;
      Uint8List loadData() {
        File file = File(imagePath);
        Uint8List bytes = file.readAsBytesSync();
        return bytes;
      }

      imageProvider = new MemoryImage(loadData());
    }
    print('album ${song.albumArt}');
    return ListTile(
      onTap: () {
        play(song, index);
      },
      leading: song.albumArt != null
          ? CircleAvatar(backgroundImage: imageProvider)
          : CircleAvatar(),
      title: Text('${song.title}', style: CustomStyle.title),
      subtitle: Text('${song.artist}', style: CustomStyle.title),
      // trailing: InkWell(
      //     child: Neumorphic(
      //   padding: EdgeInsets.all(5),
      //   style: NeumorphicStyle(
      //       shape: NeumorphicShape.concave,
      //       boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
      //       depth: 2,
      //       intensity: 0.8,
      //       lightSource: LightSource.topRight,
      //       color: CustomColors.darkButtonColor),
      //   child: Icon(
      //     Icons.play_arrow_rounded,
      //     size: 20,
      //     color: CustomColors.offWhite,
      //   ),
      // ))
    );
  }
}
