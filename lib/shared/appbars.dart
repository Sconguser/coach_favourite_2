import 'package:flutter/material.dart';

AppBar gradientAppBar = AppBar(
  title: Text('Gradient appbar'),
  titleSpacing: 1,
  flexibleSpace: Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.black26, Colors.red[700]!],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft)),
  ),
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.notifications_none),
      color: Colors.black,
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search_outlined),
      color: Colors.black,
    )
  ],
);
AppBar imageAppBar = AppBar(
  title: Text('Image appbar', style: TextStyle(color: Colors.white),),
  titleSpacing: 1,
  flexibleSpace: Container(
      decoration: BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(
       'https://sklep.ceramstic.com/1082-large_default/jungle-dark-mat-4.jpg'),
      fit: BoxFit.cover
    ),
  )),
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.notifications_none),
      color: Colors.white,
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search_outlined),
      color: Colors.white,
    )
  ],
);
AppBar imageBottomAppBar = AppBar(
  title: Text('Image appbar', style: TextStyle(color: Colors.white),),
  titleSpacing: 1,
  flexibleSpace: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://sklep.ceramstic.com/1082-large_default/jungle-dark-mat-4.jpg'),
            fit: BoxFit.cover
        ),
      )),
  actions: [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.notifications_none),
      color: Colors.white,
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search_outlined),
      color: Colors.white,
    )
  ],
  bottom: TabBar(
    indicatorColor: Colors.white,
    indicatorWeight:5,
    tabs: [
      Tab(icon:Icon(Icons.home, color: Colors.white, ), text:'Home'),
      Tab(icon:Icon(Icons.ac_unit, color:Colors.white), text:'AC'),
      Tab(icon:Icon(Icons.icecream, color:Colors.white), text:'Icecream'),

    ],
  ),
);
