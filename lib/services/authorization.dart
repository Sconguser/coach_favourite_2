import 'package:coach_favourite/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum Status{unitialized, unauthorized, authorized,}

class AuthorizationProvider extends ChangeNotifier{

  AuthorizationProvider();

  User _user = User(bearerToken: '', name: '', lastName: '', email: '', accountType: '', id:-1);
  User get user =>_user;
  Status _isAuthorized = Status.unitialized;
  Status get isAuthorized => _isAuthorized;


  Future<User>loginUser(String email, String password) async{
    try {
      final response = await http.post(
          Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/users/sign_in.json'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'password': password,
            }
          }));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode==201) {
        _user =  User.fromJson(response.headers, jsonDecode(response.body));
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      }
      else{
        print('dupa');
        _isAuthorized = Status.unauthorized;
        notifyListeners();
        return user;
      }
    }catch(e){
      print(e);
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return user;
    }
  }

  Future<User>registerUser(String email, String password,
      String passwordConfirmation, String lastName, String name, String accountType) async {
    try {
      final response = await http.post(
          Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/users.json/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'name':name,
              'lastname':lastName,
              'email': email,
              'password': password,
              'password_confirmation':passwordConfirmation,
              'account_type':accountType,
            }
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        _user =  User.fromJson(response.headers, jsonDecode(response.body));
        _isAuthorized = Status.authorized;
        notifyListeners();
        return user;
      }
      else{
        _isAuthorized = Status.unauthorized;
        notifyListeners();
        return user;
      }
    } catch (e) {
      _isAuthorized = Status.unauthorized;
      notifyListeners();
      return user;
    }
  }

  Future<User> patchUser(String bearerToken, String email, String password, String passwordConfirmation,
      String currentPassword, String lastName, String name, String accountType, int id) async{
    try{
      final response = await http.patch(
          Uri.https('scenic-mesa-verde-63784.herokuapp.com', '/users.json/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': bearerToken
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'name':name,
              'lastname':lastName,
              'email': email,
              'password': password,
              'password_confirmation':passwordConfirmation,
              'current_password':currentPassword,
            }
          }
          )
      );
      print(response.statusCode);
      if(response.statusCode==204){
        _user = User(bearerToken:bearerToken, name:name,lastName:lastName, email:email, accountType: accountType, id:id);
        notifyListeners();
        return user;
      }
      else{
        return user;
      }
    }catch(e){
      print(e);
      return user;
    }
  }

}