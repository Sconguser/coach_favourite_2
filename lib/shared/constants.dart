import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const tinyFont = TextStyle(
  fontSize: 12,
);
const smallFont = TextStyle(
  fontSize: 15,
);

const regularFont = TextStyle(
  fontSize: 20,
);
const bigFont = TextStyle(
  fontSize: 25,
);
const headerFont = TextStyle(
  fontSize: 35,
);
const enormousFont = TextStyle(
  fontSize: 50,
);
const Color orango = Color(0xFFF9A825);
const Color greyo = Color(0xFFF212121);
const signInInputDecoration = InputDecoration(
  hintStyle:hintFont,
  /*enabledBorder:UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.black, width:3.0),
  ),*/
  focusedBorder:UnderlineInputBorder(
    borderSide: BorderSide(color:Color(0xFFF9A825), width:3.0)
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:3.0)
  )
);

const errorTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 15
);


final spinner = SpinKitFoldingCube(
  color:Colors.black12,
  size: 50,
);
const titleFont = TextStyle(
  fontFamily: 'Alfa Slab One',
  color: orango
);
const titleFont2 = TextStyle(
  fontFamily: 'Tourney',
  color:Color(0xFFF9A825)
);
const titleFont3 = TextStyle(
  fontFamily: 'Saira',
  color: Color(0xFFF9A825)
);
const hintFont = TextStyle(
  color:Colors.grey
);

