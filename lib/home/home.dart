import 'dart:io';

import 'package:flexplay/data-models/songModel.dart';
import 'package:flexplay/features/allTracks/all_tracks.dart';
import 'package:flexplay/features/playList/play_list.dart';
import 'package:flexplay/home/main_screen.dart';
import 'package:flexplay/services/main-service.dart';
import 'package:flexplay/utils/colors.dart';
import 'package:flexplay/widgets/player_controls.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _cIndex = 0;
  MusicFinder audioPlayer;
  FlutterAudioQuery audioQuery;
  var files;

  @override
  void initState() {
    // TODO: implement initState
    audioQuery = FlutterAudioQuery();
    super.initState();
    getSongs();
  }

  getSongs() async {
    final provider = Provider.of<MainAppProvider>(context, listen: false);
    List<CustomSong> songs = await provider.getlocalSongs();
    print('songs $songs');
  }

  // void getFiles() async {
  //   //asyn function to get list of files
  //   List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
  //   var root = storageInfo[0]
  //       .rootDir; //storageInfo[1] for SD card, geting the root directory
  //   var fm = FileManager(root: Directory(root)); //
  //   files = await fm.filesTree(
  //       excludedPaths: ["/storage/emulated/0/Android"],
  //       extensions: ["mp3"] //optional, to filter files, list only mp3 files
  //       );
  //   print('files $files');
  //   setState(() {}); //update the UI
  // }

  // void audioQuerySearch() async {
  //   List<ArtistInfo> artists =
  //       await audioQuery.getArtists(); // returns all artists available
  //   print('artists $artists');
  //   artists.forEach((artist) {
  //     print(artist);

  //     /// prints all artist property values
  //   });
  //   // /// getting all songs available on device storage
  //   // List<SongInfo> songs = await audioQuery.getSongs();

  //   // print('song files $songs');
  // }

  final List<Widget> _children = [
    MainScreen(),
    AllTracks(),
    PlayList(),
  ];
  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: NeumorphicAppBar(
      //   // title: Text('Home'),
      //   centerTitle: true,
      // ),
      body: Stack(
        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   // mainAxisSize: MainAxisSize.max,
        children: [
          //     SingleChildScrollView(
          //         child:
          Container(
              padding: EdgeInsets.only(top: 50), child: _children[_cIndex]),
          // controls
          // Expanded(
          // child:
          // Align(
          //     alignment: Alignment.bottomCenter,
          // child:
          Positioned(bottom: 0, child: PlayerControls()),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        onTap: (index) {
          _incrementTab(index);
        }, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Neumorphic(
              padding: EdgeInsets.all(5),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                  depth: 2,
                  intensity: 0.8,
                  lightSource: LightSource.topRight,
                  color: CustomColors.buttonColor),
              child: Icon(
                Icons.home,
                size: 20,
                color: CustomColors.white,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Neumorphic(
              padding: EdgeInsets.all(5),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                  depth: 2,
                  intensity: 0.8,
                  lightSource: LightSource.topRight,
                  color: CustomColors.darkButtonColor),
              child: Icon(
                Icons.audiotrack,
                size: 20,
                color: CustomColors.offWhite,
              ),
            ),
            label: 'Songs',
          ),
          BottomNavigationBarItem(
              icon: Neumorphic(
                padding: EdgeInsets.all(5),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                    depth: 2,
                    intensity: 0.8,
                    lightSource: LightSource.topRight,
                    color: CustomColors.darkButtonColor),
                child: Icon(
                  Icons.message,
                  size: 20,
                  color: CustomColors.offWhite,
                ),
              ),
              label: 'Playlist'),
          // BottomNavigationBarItem(
          //     icon: NeumorphicIcon(
          //       Icons.person,
          //       size: 40,
          //     ),
          //     label: 'Profile')
        ],
      ),
    );
  }
}
