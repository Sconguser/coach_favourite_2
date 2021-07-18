import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:coach_favourite/shared/validators.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _storage = new FlutterSecureStorage();
  String email = '';
  String password = '';
  String error = '';
  bool isVisibleError = false;
  bool isVisibleLoading = false;
  bool saveEmail = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _readAll();
  }

  Future<Null> _readAll() async {
    final em = await _storage.read(key: 'email');
    setState(() {
      if (em != null) {
        if (em.isNotEmpty) {
          saveEmail = true;
          email = em;
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        /*appBar: AppBar(
          title: Text('Sign In'),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.how_to_reg, color: Colors.white),
              label: Text('Register', style: TextStyle(color: Colors.white)),  /// przesunac przycisk do rejestracji
              onPressed: () => Navigator.pushNamed(context, '/sign_up'),
            )
          ],
        ),*/
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', width:100, height: 100,),
                      Text('COACH FAVOURITE', style:titleFont.copyWith(fontSize:40),textAlign: TextAlign.center,),
                      SizedBox(height:50),
                      TextFormField(
                        validator: (value) {
                          if(email.isNotEmpty) value = email;
                          return inputValidator(value, 'Please enter your email');
                        },
                        decoration:
                            signInInputDecoration.copyWith(hintText: email.isEmpty ? 'Email' : 'Your email was saved previously'),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          return passwordValidator(value);
                        },
                        decoration:
                            signInInputDecoration.copyWith(hintText: 'Password', ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        value: saveEmail,
                        onChanged: (value) {
                          setState(() {
                            saveEmail = !saveEmail;
                          });
                        },
                        title: Text('Save email', style:hintFont),
                      ),
                      OutlinedButton(
                          onPressed: _signInButton, child: Text('SIGN IN', style: titleFont.copyWith(fontSize:20))),
                      Visibility(
                        child: Text(
                          error,
                          style: errorTextStyle,
                        ),
                        visible: isVisibleError,
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        child: spinner,
                        visible: isVisibleLoading,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  void _signInButton() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isVisibleLoading = true;
        isVisibleError = false;
      });
      final provider =
          Provider.of<AuthorizationProvider>(context, listen: false);
      await provider.loginUser(email, password);
      if (provider.isAuthorized == Status.unauthorized) {
        setState(() {
          error = 'Couldn\'t sign in with those credentials';
          isVisibleLoading = false;
          isVisibleError = true;
        });
      } else {
        if (saveEmail == true) {
          await _storage.write(
            key: 'email',
            value: email,
          );
        } else {
          await _storage.delete(key: 'email');
        }
        setState(() {
          isVisibleError = false;
          isVisibleLoading = false;
        });
        Navigator.pushNamed(context, '/menu');
      }
    } else {
      setState(() {
        error = 'Check your data and try again';
        isVisibleLoading = false;
        isVisibleError = true;
      });
    }
  }
}
