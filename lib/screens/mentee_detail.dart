import 'package:coach_favourite/models/mentee.dart';
import 'package:coach_favourite/models/report.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/services/report_provider.dart';

class MenteeDetail extends StatefulWidget {
  @override
  _MenteeDetailState createState() => _MenteeDetailState();
}

class _MenteeDetailState extends State<MenteeDetail> {
  @override
  Widget build(BuildContext context) {
    var menteeProvider = Provider.of<MenteeProvider>(context, listen: false);
    var auth = Provider.of<AuthorizationProvider>(context, listen: false);
    var reportProvider = Provider.of<ReportProvider>(context, listen: false);
    List<Report> reportsList = reportProvider.reportsList;
    Mentee mentee = menteeProvider.focusedMentee;
    return Scaffold(
        appBar: AppBar(
          title: Text('Mentee details'),
          actions: [
            IconButton(
                iconSize: 40,
                onPressed: () async {
                  await menteeProvider.deleteMentee(auth.user.bearerToken,
                      auth.user.id, mentee.id, mentee.id);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete_forever))
          ],
        ),
        body: Column(
          children: [
            Container(
              width: 400,
              height: 370,
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
                  Text(mentee.name, style: bigFont),
                  Text(mentee.lastName, style: bigFont),
                ],
              ),
            ),
            SizedBox(
              height: 350,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: reportsList.length,
                itemBuilder: (BuildContext context, int index) => Card(
                    child: SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      print(index);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Column(children: [
                        Center(
                          child: Text(
                              'Calf: ${reportsList.elementAt(index).calf.toString()}'),
                        ),
                        Center(
                          child: Text(
                              'Biceps: ${reportsList.elementAt(index).biceps.toString()}'),
                        ),
                        Center(
                          child: Text(
                              'Height: ${reportsList.elementAt(index).height.toString()}'),
                        ),
                      ]),
                    ),
                  ),
                )),
              ),
            )
          ],
        ));
  }
}
