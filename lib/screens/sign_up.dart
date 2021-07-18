import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:coach_favourite/shared/validators.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';
  String error='';
  String name='';
  String lastName='';
  String accountType='Mentee';
  String passwordConfirmation='';
  bool isVisibleError = false;
  bool isVisibleLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return inputValidator(value, 'Please enter your name');
                    },
                    decoration:
                    signInInputDecoration.copyWith(hintText: 'Name'),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (value) {
                      return inputValidator(value, 'Please enter your last name');
                    },
                    decoration:
                    signInInputDecoration.copyWith(hintText: 'Last name'),
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (value) {
                      return inputValidator(value, 'Please enter your email');
                    },
                    decoration:
                    signInInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (value){
                      return passwordValidator(value);
                    },
                    decoration:
                    signInInputDecoration.copyWith(hintText: 'Password'),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(height:10),
                  TextFormField(
                    validator: (value) {
                      return passwordConfirmationValidator(value,password);
                    },
                    decoration:
                    signInInputDecoration.copyWith(hintText: 'Password Confirmation'),
                    onChanged: (value) {
                      setState(() {
                        passwordConfirmation = value;
                      });
                    },
                  ),
                  SizedBox(height:10),
                  DropdownButton(
                    hint: Text('Choose account type'),
                    value: accountType,
                    onChanged: (value) {
                      setState(() {
                        accountType = value.toString();
                      });
                    },
                    items: <String>[
                      'Mentee',
                      'Coach',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  ElevatedButton(
                      onPressed: _signUpButton,
                      child: Text('Sign up')),
                  Visibility(
                    child: Text(
                      error,
                      style:errorTextStyle,
                    ),
                    visible: isVisibleError,
                  ),
                  SizedBox(height:20),
                  Visibility(
                    child: spinner,
                    visible: isVisibleLoading,
                  )
                ],
              ),
            )));
  }
  void _signUpButton() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        isVisibleLoading=true;
        isVisibleError=false;
      });
      final provider = Provider.of<AuthorizationProvider>(context,listen:false);
      await provider.registerUser(email, password,passwordConfirmation, lastName, name, accountType);
      if(provider.isAuthorized==Status.unauthorized){
        setState(() {
          error = 'Couldn\'t sign in with those credentials';
          isVisibleLoading = false;
          isVisibleError=true;
        });
      }
      else {
        setState(() {
          isVisibleError = false;
          isVisibleLoading = false;
        });
        Navigator.pushNamed(context, '/menu');
      }
    }
    else{
      setState(() {
        error = 'Check your data and try again';
        isVisibleLoading = false;
        isVisibleError=true;
      });
    }
  }

}
