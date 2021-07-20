import 'package:coach_favourite/models/mentee.dart';
import 'package:coach_favourite/models/report.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/services/report_provider.dart';

import 'loading.dart';

class MenteeDetail extends StatefulWidget {
  @override
  _MenteeDetailState createState() => _MenteeDetailState();
}

class _MenteeDetailState extends State<MenteeDetail> {

  bool isVisibleLoading = false;
  bool isVisibleLoadingBig = false;
  @override


  void initState(){
    super.initState();
    _load();
  }

  Future<Null>_load()async{
    setState(() {
      isVisibleLoading = true;
    });
    await Provider.of<ReportProvider>(context,listen:false)
        .getMenteeReports(Provider.of<AuthorizationProvider>(context,listen:false)
        .user.bearerToken,Provider.of<MenteeProvider>(context,listen:false).focusedMentee.id);
    setState(() {
      isVisibleLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var menteeProvider = Provider.of<MenteeProvider>(context, listen: false);
    var auth = Provider.of<AuthorizationProvider>(context, listen: false);
    var reportProvider = Provider.of<ReportProvider>(context, listen: false);
    List<Report> reportsList = reportProvider.reportsList;
    Mentee mentee = menteeProvider.focusedMentee;
    return isVisibleLoadingBig?Loading():Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                iconSize: 40,
                onPressed: () async {
                  setState(() {
                    isVisibleLoadingBig = true;
                  });
                  await menteeProvider.deleteMentee(auth.user.bearerToken,
                      auth.user.id, mentee.id, mentee.id);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
        body: ListView(
          children: [
            Container(
              width: 400,
              height: 400,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Hero(
                    tag: 'cat${mentee.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/Cat_${mentee.id % 30 + 1}.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  Text(mentee.name, style: titleFont.copyWith(fontSize:30)),
                  Text(mentee.lastName, style: titleFont.copyWith(fontSize:30)),
                ],
              ),
            ),
            isVisibleLoading?spinner:SizedBox(
              height: 200,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: reportsList.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  elevation: 20,
                    child: SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      reportProvider.setFocusedReport = reportsList.elementAt(index);
                      Navigator.pushNamed(context, '/report_detail');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Center(
                        child: Text(reportsList.elementAt(index).date.substring(0,10), style: titleFont.copyWith(fontSize:25),),
                      ),
                    ),
                  ),
                )),
              ),
            )
          ],
        ));
  }
  String truncateTime(String time){
    return (time.split("T")[1]).split(":")[0]+':'+(time.split("T")[1]).split(":")[1];
  }
}
