import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coach_favourite/models/mentee.dart';

class MenteeProvider extends ChangeNotifier{
  MenteeProvider();

  List<Mentee>_mentees=[];

  List<Mentee> get mentees =>_mentees;

  Mentee _focusedMentee=Mentee(id:0,name:'',lastName: '',email: '');

  Mentee get focusedMentee =>_focusedMentee;
  set setFocusedMentee(mentee){
    _focusedMentee = mentee;
    notifyListeners();
  }

  Future<List<Mentee>>getMentees(String bearerToken) async{
    try {
      final response = await http.get(
        Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/mentees.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      print('get mentees');
      print(response.statusCode);
      if (response.statusCode == 200) {
        _mentees.clear();
        List menteees = jsonDecode(response.body);
        menteees.forEach((mentee) =>
            _mentees.add(Mentee.fromJson(mentee)));
        notifyListeners();
        return _mentees;
      }
      else{
        notifyListeners();
        return _mentees;
      }
    } catch(e) {
      print(e);
      print('Failed');
      notifyListeners();
      return _mentees;
    }
  }
  Future<void>addMentee (String bearerToken, int idCoach, int idMentee, String name, String lastName, String email)async{
    try{
      final response = await http.post(
        Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/relations.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
        body: jsonEncode(<String, dynamic>{
          'relation': {
            'coach_id': idCoach,
            'mentee_id': idMentee,
          }
        }));
      print('add mentee');
      print(response.statusCode);
      if(response.statusCode==200){
        _mentees.add(Mentee(id:idMentee,name: name, lastName: lastName, email: email ));
        notifyListeners();
        return ;
      }
      else{
        notifyListeners();
        return ;
      }
    }
    catch(e){
      throw e;
    }
  }
  Future<void>deleteMentee (String bearerToken, int idCoach, int idMentee, int idDel)async{
    try{
      final response = await http.delete(
          Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/relations/$idDel'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'relation': {
              'coach_id': idCoach,
              'mentee_id': idMentee,
            }
          }));
      print('delete mentee');
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        await getMentees(bearerToken);
        return;
      }
      else{
        notifyListeners();
        return ;
      }
    }
    catch(e){
      throw e;
    }
  }
}