import 'package:flexplay/utils/colors.dart';
import 'package:flexplay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DashboardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardViewState();
  }
}

class DashboardViewState extends State<DashboardView> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // feed
        ListTile(
            title: Text('Feeds', style: CustomStyle.header1),
            trailing: InkWell(
                child: Icon(
              Icons.keyboard_arrow_right,
              color: CustomColors.buttonColor,
            ))),

        ListTile(
          leading: CircleAvatar(),
          title: Text(
              'Adebanji Solomon is listening made a way by travis green',
              style: CustomStyle.title),
          subtitle: Text('9:54PM', style: CustomStyle.title),
        ),
        ListTile(
          leading: CircleAvatar(),
          title: Text(
              'Adebanji Solomon is listening made a way by travis green',
              style: CustomStyle.title),
          subtitle: Text('9:54PM', style: CustomStyle.title),
        ),
        ListTile(
          leading: CircleAvatar(),
          title: Text(
              'Adebanji Solomon is listening made a way by travis green',
              style: CustomStyle.title),
          subtitle: Text('9:54PM', style: CustomStyle.title),
        ),
        // recent track
        SizedBox(height: 30),
        ListTile(
            title: Text('Recently played', style: CustomStyle.header1),
            trailing: InkWell(
                child: Icon(
              Icons.keyboard_arrow_right,
              color: CustomColors.buttonColor,
            ))),
        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

        // ]),

        ListTile(
            leading: CircleAvatar(),
            title: Text('Love is beautiful', style: CustomStyle.title),
            subtitle: Text('Jordan Sparks', style: CustomStyle.title),
            trailing: InkWell(
                child: Neumorphic(
              padding: EdgeInsets.all(5),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                  depth: 2,
                  intensity: 0.8,
                  lightSource: LightSource.topRight,
                  color: CustomColors.buttonColor),
              child: Icon(Icons.pause, color: CustomColors.white, size: 20),
            )
                // child: NeumorphicIcon(
                //   Icons.play_arrow_rounded,
                //   size: 40,
                // ),
                )),
        ListTile(
            leading: CircleAvatar(),
            title: Text('Promises', style: CustomStyle.title),
            subtitle: Text('Maverick City Music', style: CustomStyle.title),
            trailing: InkWell(
                child: Neumorphic(
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
                Icons.play_arrow_rounded,
                size: 20,
                color: CustomColors.offWhite,
              ),
            ))),
        ListTile(
            leading: CircleAvatar(),
            title: Text('Come and behold Him', style: CustomStyle.title),
            subtitle: Text('Maverick City Music', style: CustomStyle.title),
            trailing: InkWell(
                child: Neumorphic(
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
                Icons.play_arrow_rounded,
                size: 20,
                color: CustomColors.offWhite,
              ),
            ))),
      ],
    ));
  }
}
