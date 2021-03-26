import 'package:flexplay/widgets/player_controls.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlayListState();
  }
}

class PlayListState extends State<PlayList> {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SingleChildScrollView(
        //     child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(child: Center(child: Text('PlayList')))]),
        // ),
        Positioned(bottom: 0, child: PlayerControls())
      ],
    );
  }
}
