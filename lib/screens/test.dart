import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/appbars.dart';


class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:imageBottomAppBar,
        body:Container(

        )
      ),
    );
  }
}
