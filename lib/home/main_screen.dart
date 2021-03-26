import 'package:flexplay/features/dashboard/dashboard.dart';
import 'package:flexplay/features/feeds/feeds.dart';
import 'package:flexplay/utils/colors.dart';
import 'package:flexplay/utils/style.dart';
import 'package:flexplay/widgets/player_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // toggle

        Column(children: [
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: NeumorphicToggle(
                height: 40,
                selectedIndex: _selectedIndex,
                displayForegroundOnlyIfSelected: true,
                style: NeumorphicToggleStyle(depth: 1),
                children: [
                  ToggleElement(
                    background: Center(
                        child: Text(
                      "Music",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    foreground: Center(
                        child: Text(
                      "Music",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: CustomColors.buttonColor),
                    )),
                  ),
                  ToggleElement(
                    background: Center(
                        child: Text(
                      "Timeline",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    foreground: Center(
                        child: Text(
                      "Timeline",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: CustomColors.buttonColor),
                    )),
                  ),
                ],
                thumb: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)))),
                onChanged: (value) {
                  setState(() {
                    print('value $value');
                    _selectedIndex = value;
                    print("_firstSelected: $_selectedIndex");
                  });
                },
              )),
          SizedBox(height: 20),
          // content
          _selectedIndex == 0 ? DashboardView() : FeedsView(),
        ]),
        // Positioned(bottom: 0, child: PlayerControls())
      ],
    );
  }
}
