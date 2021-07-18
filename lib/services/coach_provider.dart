import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coach_favourite/models/coach.dart';

class CoachProvider extends ChangeNotifier{
  CoachProvider();

  List<Coach>_coaches=[];

  List<Coach> get coaches =>_coaches;

  Future<List<Coach>>getCoaches(String bearerToken) async{
    try {
      final response = await http.get(
        Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/coaches.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        _coaches.clear();
        List coaches = jsonDecode(response.body);
        coaches.forEach((coach) =>
            _coaches.add(Coach.fromJson(coach)));
        notifyListeners();
        return _coaches;
      }
      else{
        notifyListeners();
        return _coaches;
      }
    } catch(e) {
      print(e);
      print('Failed');
      notifyListeners();
      return _coaches;
    }
  }

}