import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coach_favourite/models/report.dart';
import 'dart:async';

class ReportProvider extends ChangeNotifier{
  ReportProvider();
  Report _report= Report(id:-1, menteeId: -1, date:'');
  Report get report =>_report;
  int _lastReportId =-1;
  int get lastReportId =>_lastReportId;
  List<Report> _reportsList = [];
  List<Report> get reportsList => _reportsList;

  Future<int>createReport(String bearerToken,int menteeId, double calf, double hips, double belly, double waist,
      double chest, double biceps,double weight, double height, String dietOpinion, String workoutOpinion) async{
    try{
      final response = await http.post(
          Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/reports.json'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'calf':calf,
            'hips':hips,
            'belly':belly,
            'waist':waist,
            'chest':chest,
            'biceps':biceps,
            'weight':weight,
            'height':height,
            'diet_opinion':dietOpinion,
            'workout_opinion':workoutOpinion
          }));
      print('create report');
      print(response.statusCode);
      if (response.statusCode==201) {
         _lastReportId = jsonDecode(response.body)['report_id'];
        notifyListeners();
        return lastReportId;
      }
      else{
        notifyListeners();
        return -1;
      }
    }catch(e){
      print(e);
      notifyListeners();
      return -1;
    }
    }


  Future<void>sendReport(String bearerToken,int reportId, List<int>coachesId) async {
    for (int id in coachesId) {
      try {
        final response = await http.post(
            Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/coach_reports'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': bearerToken
            },
            body: jsonEncode(<String, dynamic>
              {
                "coach_report": {
                  "coach_id": id,
                  "report_id": reportId
                }
              }
            )
        );
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 201) {
            print('git $id');
        }
        else {
          return;
        }
      } catch (e) {
        return;
      }
    }
    return;
  }

  Future<List<Report>>getMenteeReports(String bearerToken, int menteeId)async{
    try{
      final response = await http.get(
        Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/reports',{'with_mentee_id':'$menteeId'}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      print('get reports');
      print(response.statusCode);
      if(response.statusCode==200){
        _reportsList.clear();
        List reports = jsonDecode(response.body);
        reports.forEach((report)=>
        _reportsList.add(Report.fromJson(report))
        );
        print(_reportsList.elementAt(0).date);
        notifyListeners();
        return _reportsList;
      }
      else{
        notifyListeners();
        return _reportsList;
      }
    }
    catch(e){
      throw(e);

    }
  }

}