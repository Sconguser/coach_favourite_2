import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:flutter/material.dart';
import 'shared/routes.dart';
import 'package:provider/provider.dart';
import 'services/authorization.dart';
import 'services/coach_provider.dart';
import 'services/all_mentees_provider.dart';
import 'services/report_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorizationProvider>(
            create:(context)=>AuthorizationProvider()
        ),
        ChangeNotifierProvider(
            create:(context)=>CoachProvider()
        ),
        ChangeNotifierProvider(
            create:(context)=>MenteeProvider()
        ),
        ChangeNotifierProvider(
            create:(context)=>AllMenteeProvider()
        ),
        ChangeNotifierProvider(
            create: (context)=>ReportProvider()
        )
      ],
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: MaterialApp(
          routes: myRoutes,
          title: 'Coach Favourite',
          theme: ThemeData(
            primarySwatch: Colors.grey,

            canvasColor: greyo,
            buttonColor: orango,
            appBarTheme: AppBarTheme(
                backgroundColor:greyo,
                actionsIconTheme: IconThemeData(color:orango),
                iconTheme: IconThemeData(color: orango),
                elevation: 0
            ),
            scaffoldBackgroundColor: greyo,
            dialogBackgroundColor: greyo,
            cardColor: greyo,
          ),
          initialRoute: '/',
        ),
      ),
    );
  }
}
