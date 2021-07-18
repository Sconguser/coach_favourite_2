import 'package:coach_favourite/services/authorization.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/divider.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/services/coach_provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            tileColor: Colors.transparent,
            onTap: () {},
            title: Text(
              'Edit profile',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          MySmallDivider(),
          ListTile(
            tileColor: Colors.transparent,
            onTap: () {},
            title: Text(
              'Coach list',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            tileColor: Colors.transparent,
            onTap: () {},
            title: Text(
              'Create a report',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class CoachDrawer extends StatefulWidget {
  @override
  _CoachDrawerState createState() => _CoachDrawerState();
}

class _CoachDrawerState extends State<CoachDrawer> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthorizationProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            tileColor: Colors.transparent,
            onTap: () async {
              await Navigator.popAndPushNamed(context, '/edit_profile');
              setState(() {
                dispose();
              });
            },
            title: Text(
              'Edit profile',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          MySmallDivider(),
          ListTile(
            tileColor: Colors.transparent,
            onTap: () async {
              await Provider.of<MenteeProvider>(context, listen: false)
                  .getMentees(provider.user.bearerToken);
              await Navigator.pushNamed(context, '/mentees_list');
            },
            title: Text(
              'Mentee list',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
    ;
  }
}








class MenteeDrawer extends StatefulWidget {
  @override
  _MenteeDrawerState createState() => _MenteeDrawerState();
}

class _MenteeDrawerState extends State<MenteeDrawer> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthorizationProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            tileColor: Colors.transparent,
            onTap: () async {
              await Navigator.popAndPushNamed(context, '/edit_profile');
              setState(() {
                dispose();
              });
            },
            title: Text(
              'Edit profile',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          MySmallDivider(),
          ListTile(
            tileColor: Colors.transparent,
            onTap: () async {
              await Provider.of<CoachProvider>(context, listen: false)
                  .getCoaches(provider.user.bearerToken);
              await Navigator.pushNamed(context, '/coaches_list');
            },
            title: Text(
              'Coach list',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            tileColor: Colors.transparent,
            onTap: () async {
              await Navigator.pushNamed(context, '/create_report');
            },
            title: Text(
              'Create a report',
              style: titleFont3.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
