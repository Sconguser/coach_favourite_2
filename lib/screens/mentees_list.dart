import 'package:coach_favourite/models/mentee.dart';
import 'package:coach_favourite/screens/loading.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/shared/constants.dart';
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

  bool isVisibleLoading = false;
  @override

  void initState(){
    super.initState();
    _load();
  }

  Future<Null>_load()async{
    setState(() {
      isVisibleLoading = true;
    });
    await Provider.of<MenteeProvider>(context,listen:false)
        .getMentees(Provider.of<AuthorizationProvider>(context,listen:false)
        .user.bearerToken);
    setState(() {
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    timeDilation=1.0;
    var menteeProvider = Provider.of<MenteeProvider>(context,listen:false);
    var auth = Provider.of<AuthorizationProvider>(context,listen:false);
    var reportProvider = Provider.of<ReportProvider>(context,listen:false);
    List<Mentee> mentees = menteeProvider.mentees;
    return isVisibleLoading?Loading():Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        width: 400,
        height: 400,
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [
            for (var mentee in mentees)
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Hero(
                      tag:'cat${mentee.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap:()async {
                            menteeProvider.setFocusedMentee = mentee;
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
                    Text(mentee.name,style:titleFont.copyWith(fontSize: 15)),
                    Text(mentee.lastName,style:titleFont.copyWith(fontSize: 15))
                  ],
                ),
              ),
            Column(
              children: [
                InkWell(
                  onTap:()async {
                    setState(() {
                      isVisibleLoading = true;
                    });
                    await Provider.of<AllMenteeProvider>(context,listen:false).getMentees(auth.user.bearerToken);
                    await Navigator.pushNamed(context, '/add_mentee');
                    mentees= await menteeProvider.getMentees(auth.user.bearerToken);
                    setState((){
                      isVisibleLoading = false;
                    });
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/add.png', width: 110, height: 100,),
                    ),
                  ),
                ),
                Text('Add', style:TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
