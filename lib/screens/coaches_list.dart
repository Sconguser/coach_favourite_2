import 'package:coach_favourite/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/services/coach_provider.dart';
import 'package:provider/provider.dart';

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
        title: Text('Coaches list'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [
            for (var coach in coaches)
            Column(
              children: [
                InkWell(
                  onTap:(){},
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/Dog_${coach.id%30+1}.png', width: 120, height: 100,),
                    ),
                  ),
                ),
                Text(coach.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
