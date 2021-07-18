import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color:Colors.purple,
      height: 10,
      thickness: 4,);
  }
}
class MySmallDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color:Colors.grey[800],
      height: 1,
      thickness: 1,);
  }
}