import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/screens/sign_in.dart';
import 'package:coach_favourite/screens/menu.dart';
import 'package:coach_favourite/screens/sign_up.dart';
import 'package:coach_favourite/screens/edit_profile.dart';
import 'package:coach_favourite/screens/coaches_list.dart';
import 'package:coach_favourite/screens/mentees_list.dart';
import 'package:coach_favourite/screens/add_mentee.dart';
import 'package:coach_favourite/screens/mentee_detail.dart';
import 'package:coach_favourite/screens/create_report.dart';
import 'package:coach_favourite/screens/test.dart';
import 'package:coach_favourite/screens/select_coaches.dart';
import 'package:coach_favourite/screens/report_detail.dart';

var myRoutes = <String,WidgetBuilder>{
  '/': (context) => SignIn(),
  '/menu':(context) =>Menu(),
  '/sign_up':(context)=>SignUp(),
  '/edit_profile':(context)=>EditProfile(),
  '/coaches_list':(context)=>CoachesList(),
  '/mentees_list':(context)=>MenteesList(),
  '/add_mentee':(context)=>AddMentee(),
  '/mentee_detail':(context)=>MenteeDetail(),
  '/create_report':(context)=>CreateReport(),
  '/test':(context)=>Test(),
  '/select_coaches':(context)=>SelectCoaches(),
  '/report_detail':(context)=>ReportDetail()
};