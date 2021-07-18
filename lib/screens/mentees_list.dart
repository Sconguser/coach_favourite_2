import 'package:coach_favourite/models/mentee.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/all_mentees_provider.dart';
import 'package:coach_favourite/services/report_provider.dart';


class MenteesList extends StatefulWidget {
  @override
  _MenteesListState createState() => _MenteesListState();
}

class _MenteesListState extends State<MenteesList> {


  @override

  Widget build(BuildContext context) {
    timeDilation=1.0;
    var menteeProvider = Provider.of<MenteeProvider>(context,listen:false);
    var auth = Provider.of<AuthorizationProvider>(context,listen:false);
    var reportProvider = Provider.of<ReportProvider>(context,listen:false);
    List<Mentee> mentees = menteeProvider.mentees;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentees list'),
      ),
      body: Container(
        width: 400,
        height: 400,
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [
            for (var mentee in mentees)
              Column(
                children: [
                  Hero(
                    tag:'cat${mentee.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap:()async {print('klikniete!');
                          menteeProvider.setFocusedMentee = mentee;
                          await reportProvider.getMenteeReports(auth.user.bearerToken, mentee.id);
                          await Navigator.pushNamed(context,'/mentee_detail');
                          setState(() {

                          });
                          },
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/Cat_${mentee.id%30+1}.png', width: 120, height: 100,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(mentee.name),
                  Text(mentee.lastName)
                ],
              ),
            Column(
              children: [
                InkWell(
                  onTap:()async {
                    await Provider.of<AllMenteeProvider>(context,listen:false).getMentees(auth.user.bearerToken);
                    await Navigator.pushNamed(context, '/add_mentee');
                    mentees= await menteeProvider.getMentees(auth.user.bearerToken);
                    setState((){});
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/add.png', width: 120, height: 100,),
                    ),
                  ),
                ),
                Text('Add'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
