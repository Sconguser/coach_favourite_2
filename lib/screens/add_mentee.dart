import 'package:coach_favourite/models/mentee.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/all_mentees_provider.dart';
import 'package:coach_favourite/shared/are_you_sure_alert.dart';


class AddMentee extends StatefulWidget {
  @override
  _AddMenteeState createState() => _AddMenteeState();
}

class _AddMenteeState extends State<AddMentee> {
  @override
  Widget build(BuildContext context) {
    List<Mentee> allMentees =
        Provider.of<AllMenteeProvider>(context, listen: false).allMentees;
    var auth = Provider.of<AuthorizationProvider>(context,listen:false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a mentee'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              for (var mentee in allMentees)
                Column(children: [
                  InkWell(
                    onTap: ()async
                    {
                      showAddManteeDialog(context, auth.user.bearerToken,
                        auth.user.id, mentee.id, mentee.name,
                        mentee.lastName, mentee.email);
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/Cat_${mentee.id % 30 + 1}.png',
                          width: 120,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  Text(mentee.name),
                ])
            ],
          ),
        ));
  }
}
