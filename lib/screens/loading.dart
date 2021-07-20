import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/constants.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyo,
      child: Center(
        child: spinner,
      ),
    );
  }
}
