import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coach_favourite/models/mentee.dart';

class AllMenteeProvider extends ChangeNotifier{
  AllMenteeProvider();

  List<Mentee>_allMentees=[];

  List<Mentee> get allMentees =>_allMentees;

  Future<List<Mentee>>getMentees(String bearerToken) async{
    try {
      final response = await http.get(
        Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/mentees/all.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        _allMentees.clear();
        List menteees = jsonDecode(response.body);
        menteees.forEach((mentee) =>
            _allMentees.add(Mentee.fromJson(mentee)));
        notifyListeners();
        return _allMentees;
      }
      else{
        notifyListeners();
        return _allMentees;
      }
    } catch(e) {
      print(e);
      print('Failed');
      notifyListeners();
      return _allMentees;
    }
  }

}