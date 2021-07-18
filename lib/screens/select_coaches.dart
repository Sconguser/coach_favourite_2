import 'package:coach_favourite/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/services/coach_provider.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/report_provider.dart';
import 'package:coach_favourite/services/authorization.dart';


class SelectCoaches extends StatefulWidget {
  @override
  _SelectCoachesState createState() => _SelectCoachesState();
}

class _SelectCoachesState extends State<SelectCoaches> {

  List<int>selectedCoaches=[];
  @override

  Widget build(BuildContext context) {
    var coachProvider = Provider.of<CoachProvider>(context,listen:false);
    var reportProvider = Provider.of<ReportProvider>(context,listen:false);
    var auth = Provider.of<AuthorizationProvider>(context,listen:false);

    List<Coach> coaches = coachProvider.coaches;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select coaches'),
        actions: [
          ElevatedButton(onPressed: ()async {
            if(selectedCoaches.isNotEmpty){
              await reportProvider.sendReport(auth.user.bearerToken, reportProvider.lastReportId, selectedCoaches);
              Navigator.pop(context);
            }
          }, child: Text('Send!'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [
            for (var coach in coaches)
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: selectedCoaches.contains(coach.id)? Colors.blue : Colors.white,
                      blurRadius: 5.0,
                      offset: Offset(0,2),
                      spreadRadius: 0.2
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap:(){
                        print(selectedCoaches);
                          if(selectedCoaches.contains(coach.id)){
                            setState(() {
                                selectedCoaches.remove(coach.id);
                                print('gowno');
                            });
                          }
                          else
                            {
                              setState(() {
                                selectedCoaches.add(coach.id);
                                print(selectedCoaches);
                                print('dodalismy');
                              });
                            }
                      },
                      child: Container(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/images/Dog_${coach.id%30+1}.png', width: 120, height: 100,),
                        ),
                      ),
                    ),
                    Text(coach.name),
                  ],
                ),
              ),
            /*ElevatedButton(
              onPressed: (){},
              child: Text('Send report to selected coaches'),
            )*/
          ],
        ),
      ),
    );
  }
}
