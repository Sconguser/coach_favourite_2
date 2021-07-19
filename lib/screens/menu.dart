import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:coach_favourite/shared/drawer.dart';
import 'package:coach_favourite/services/coach_provider.dart';
import 'package:coach_favourite/shared/appbars.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthorizationProvider>(context, listen: false);
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.dehaze_rounded, color: orango, size:40), onPressed: (){
          scaffoldKey.currentState!.openDrawer();
          setState(() {
          });
        },),
      ),
      drawer: provider.user.accountType=='Mentee' ? MenteeDrawer() : CoachDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/Cat_${provider.user.id % 30 + 1}.png',
                  ),
                  radius: 100,
                ),
                SizedBox(height:20),
                Text(provider.user.name, style: bigFont.copyWith(color: orango),),
                SizedBox(height: 20),
                Text(provider.user.lastName, style: bigFont.copyWith(color:orango)),
                SizedBox(height: 20),
                Text(provider.user.accountType, style: bigFont.copyWith(color:orango)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonCoach extends StatelessWidget {
  const ButtonCoach({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final AuthorizationProvider provider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await Provider.of<MenteeProvider>(context, listen: false)
              .getMentees(provider.user.bearerToken);
          await Navigator.pushNamed(context, '/mentees_list');
        },
        child: Text('Mentees list'));
  }
}

class ButtonMentee extends StatelessWidget {
  const ButtonMentee({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final AuthorizationProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              await Provider.of<CoachProvider>(context, listen: false)
                  .getCoaches(provider.user.bearerToken);
              await Navigator.pushNamed(context, '/coaches_list');
            },
            child: Text('Coaches list')),
        ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/create_report');
            },
            child: Text('Create report'))
      ],
    );
  }
}
