import 'package:flutter/material.dart';

class FeedsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeedsViewState();
  }
}

class FeedsViewState extends State<FeedsView> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(child: Center(child: Text('feeds here')))]));
  }
}
