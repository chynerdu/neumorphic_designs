import 'dart:async';
import 'dart:convert';

import 'package:flexplay/data-models/songModel.dart';
import 'package:flexplay/services/main-service.dart';
import 'package:flexplay/utils/colors.dart';
import 'package:flexplay/utils/style.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerControls extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlayerControlsState();
  }
}

class PlayerControlsState extends State<PlayerControls> {
  // double playTimer = 0.0;

  StreamController<double> playTimerStream;
  StreamController<CustomSong> currentlyPlayingStream;
  var timer;
  SharedPreferences prefs;
  initState() {
    playTimerStream = new StreamController<double>();
    playTimerStream.add(0.0);
    currentlyPlayingStream = new StreamController<CustomSong>();
    currentlyPlayingStream.add(null);
    // WidgetsBinding.instance.addPostFrameCallback((_) => initializa());
    // print('${provider.player.getCurrentAudioAlbum}');
    // initialize();
    // timer = Timer(Duration(seconds: 3), () {
    //   initialize();
    // });
    super.initState();
  }

  initialize() async {
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    prefs = await SharedPreferences.getInstance();
    await provider.listenersDurationandTrack();
    provider.playtimer.listen((double count) {
      // rebuildAllChildren(context);
      // timer.cancel();
      playTimerStream.add(count);
    });

    provider.currentlyPlaying.listen((CustomSong song) {
      // rebuildAllChildren(context);
      // timer.cancel();
      // get song from state if not null else use shared preference

      if (song != null) {
        currentlyPlayingStream.add(song);
        print('not null $song');
      } else {
        var currentlyPlaying = json.decode(prefs.getString('currentlyPlaying'));
        print('retrievd $currentlyPlaying');
        currentlyPlayingStream.add(currentlyPlaying.currentlyPlaying);
      }
    });
  }

  // dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Widget build(BuildContext context) {
    initialize();
    // initializa(context);
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    return Neumorphic(
        style: NeumorphicStyle(
            depth: 1,
            intensity: 0.2,
            border: NeumorphicBorder(
              color: Color(0x33000000),
              width: 0.5,
            )),
        child: StreamBuilder(
            stream: currentlyPlayingStream.stream,
            builder: (BuildContext context, currentlyPlayingSnapshot) {
              return StreamBuilder(
                  stream: playTimerStream.stream,
                  builder: (BuildContext context, snapshot) {
                    return Container(
                        // color: CustomColors.darkButtonColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            NeumorphicSlider(
                                min: 0,
                                max: provider.songDuration,
                                value: snapshot.data,
                                height: 5,
                                style: SliderStyle(
                                    variant: CustomColors.lightColor,
                                    accent: CustomColors.buttonColor)),
                            Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListTile(
                                    // leading: CircleAvatar(),
                                    title: Text(
                                        currentlyPlayingSnapshot.data == null
                                            ? '--'
                                            : '${currentlyPlayingSnapshot.data.title}',
                                        style: CustomStyle.title),
                                    subtitle: Text(
                                        currentlyPlayingSnapshot.data == null
                                            ? '--'
                                            : '${currentlyPlayingSnapshot.data.artist}',
                                        style: CustomStyle.title),
                                    trailing: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  provider.playPrevious(provider
                                                      .currentSongIndex);
                                                },
                                                child: Neumorphic(
                                                  padding: EdgeInsets.all(5),
                                                  style: NeumorphicStyle(
                                                      shape: NeumorphicShape
                                                          .concave,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                      depth: 2,
                                                      intensity: 0.8,
                                                      lightSource:
                                                          LightSource.topRight,
                                                      color: CustomColors
                                                          .darkButtonColor),
                                                  child: Icon(
                                                    Icons.skip_previous,
                                                    size: 15,
                                                    color:
                                                        CustomColors.offWhite,
                                                  ),
                                                )),
                                            StreamBuilder(
                                                stream:
                                                    provider.player.isPlaying,
                                                builder:
                                                    (context, asyncSnapshot) {
                                                  final bool isPlaying =
                                                      asyncSnapshot.data;
                                                  return InkWell(
                                                      onTap: () {
                                                        provider.player
                                                            .playOrPause();
                                                      },
                                                      child: Neumorphic(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        style: NeumorphicStyle(
                                                            shape: NeumorphicShape
                                                                .concave,
                                                            boxShape: NeumorphicBoxShape
                                                                .roundRect(
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            depth: 2,
                                                            intensity: 0.8,
                                                            lightSource:
                                                                LightSource
                                                                    .topRight,
                                                            color: isPlaying
                                                                ? CustomColors
                                                                    .buttonColor
                                                                : CustomColors
                                                                    .darkButtonColor),
                                                        child: Icon(
                                                            isPlaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow,
                                                            color: CustomColors
                                                                .white,
                                                            size: 20),
                                                      )
                                                      // child: NeumorphicIcon(
                                                      //   Icons.play_arrow_rounded,
                                                      //   size: 40,
                                                      // ),
                                                      );
                                                }),
                                            InkWell(
                                                onTap: () {
                                                  provider.playNext(provider
                                                      .currentSongIndex);
                                                },
                                                child: Neumorphic(
                                                  padding: EdgeInsets.all(5),
                                                  style: NeumorphicStyle(
                                                      shape: NeumorphicShape
                                                          .concave,
                                                      boxShape:
                                                          NeumorphicBoxShape
                                                              .roundRect(
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                      depth: 2,
                                                      intensity: 0.8,
                                                      lightSource:
                                                          LightSource.topRight,
                                                      color: CustomColors
                                                          .darkButtonColor),
                                                  child: Icon(
                                                    Icons.skip_next,
                                                    size: 15,
                                                    color:
                                                        CustomColors.offWhite,
                                                  ),
                                                )),
                                          ],
                                        )))),
                          ],
                        ));
                  });
            }));
  }
}
