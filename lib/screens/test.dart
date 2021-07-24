import 'package:coach_favourite/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/appbars.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/authorization.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState(){
    super.initState();
    LocalNotificationService.initialize(context);
    AuthorizationProvider auth = Provider.of(context,listen:false);

    FirebaseMessaging.instance.getInitialMessage().then((message){
      if(message!=null){
        final routeFromMessage = message.data["route"];
        if(auth.isAuthorized == Status.authorized){
          print('gowno');
          Navigator.pushNamed(context,routeFromMessage);
        }
        else Navigator.pushReplacementNamed(context,'/sign_in');
      }
    });


    ///foreground
    FirebaseMessaging.onMessage.listen((message) {
      print('dotarlem tu');
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    }
    );
    /// app in background but open and user taps on notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      print(routeFromMessage);
      if(auth.isAuthorized == Status.authorized)Navigator.pushNamed(context,routeFromMessage);
      else Navigator.pushNamed(context,'/sign_in');
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:imageBottomAppBar,
        body:Container(
        )
      ),
    );
  }
}
