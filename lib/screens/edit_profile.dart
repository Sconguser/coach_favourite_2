import 'package:coach_favourite/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/shared/constants.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name='';
  String lastName='';
  String password='';
  String error ='';
  bool isVisibleLoading=false;
  bool isVisibleError=false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthorizationProvider>(context,listen:false);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body:Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key:_formKey,
          child:Column(
            children:[
              TextFormField(
                initialValue: auth.user.name,
              validator: (value) {
                return inputValidator(value, 'Please enter your name');
              },
                decoration: signInInputDecoration.copyWith(hintText: 'Name'),
                onChanged:(value){
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height:10),
              TextFormField(
                initialValue: auth.user.lastName,
                validator: (value) {
                  return inputValidator(value, 'Please enter your last name');
                },
                decoration: signInInputDecoration.copyWith(hintText: 'Last name'),
                onChanged:(value){
                  setState(() {
                    lastName = value;
                  });
                },
              ),
              SizedBox(height:10),
              TextFormField(
                validator: (value) {
                  return passwordValidator(value);
                },
                decoration: signInInputDecoration.copyWith(hintText: 'Password'),
                onChanged:(value){
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height:20),
              OutlinedButton(
                  onPressed: _editButton,
                  child: Text('CHANGE', style: titleFont)),
              Visibility(
                child: Text(
                  error,
                  style:errorTextStyle,
                ),
                visible: isVisibleError,
              ),
              SizedBox(height:10),
              Visibility(
                child: spinner,
                visible: isVisibleLoading,
              )
            ],

          )
        ),
      )
    );
  }
  void _editButton() async{
    final provider = Provider.of<AuthorizationProvider>(context,listen:false);
    if(_formKey.currentState!.validate()){
      setState(() {
        if(name.isEmpty) name = provider.user.name;
        if(lastName.isEmpty) lastName = provider.user.lastName;
        isVisibleLoading=true;
        isVisibleError=false;
      });

      await provider.patchUser(provider.user.bearerToken,provider.user.email, password, password, password, lastName,
      name, provider.user.accountType, provider.user.id);
      if(provider.isAuthorized==Status.unauthorized){
        setState(() {
          error = 'Couldn\'t edit profile';
          isVisibleLoading = false;
          isVisibleError=true;
        });
      }
      else {
        setState(() {
          isVisibleError = false;
          isVisibleLoading = false;
        });
        Navigator.pop(context);
        setState(() {
             ///// zadziala?
        });
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
