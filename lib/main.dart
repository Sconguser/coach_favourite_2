import 'package:coach_favourite/services/local_notification_service.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:flutter/material.dart';
import 'shared/routes.dart';
import 'package:provider/provider.dart';
import 'services/authorization.dart';
import 'services/coach_provider.dart';
import 'services/all_mentees_provider.dart';
import 'services/report_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
late FirebaseAnalytics analytics;

//receive message when app is in background
Future<void>backgroundHandler(RemoteMessage message)async{
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  analytics = FirebaseAnalytics();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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
          initialRoute: '/test',
        ),
      ),
    );
  }
}
