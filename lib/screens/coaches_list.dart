import 'package:coach_favourite/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/services/coach_provider.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/shared/constants.dart';


class CoachesList extends StatefulWidget {
  @override
  _CoachesListState createState() => _CoachesListState();
}

class _CoachesListState extends State<CoachesList> {


  @override

  Widget build(BuildContext context) {
    var coachProvider = Provider.of<CoachProvider>(context,listen:false);
    List<Coach> coaches = coachProvider.coaches;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyo,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            for (var coach in coaches)
            Column(
              children: [
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){},
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset('assets/images/Dog_${coach.id%30+1}.png', width: 300, height: 300,),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Text(coach.name, style: titleFont.copyWith(fontSize:20),),
                      Text(coach.lastName, style:titleFont.copyWith(fontSize:20)),
                      SizedBox(height:10)
                    ],
                  ),
                ),
                SizedBox(height:30)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
