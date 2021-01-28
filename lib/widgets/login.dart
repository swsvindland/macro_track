import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MacroTrack/utils/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences prefs;

  var email = '';

  @override
  void initState() {
    super.initState();
  }

  void onSubmit() async {
    prefs = await SharedPreferences.getInstance();

    await Api.sendLoginCode(email);
    prefs.setString('email', email);
    navigatorKey.currentState.pushNamed('/enterCode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            RaisedButton(
              onPressed: () {
                onSubmit();
              },
              child: Text('Login'),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            ),
            FlatButton(
              onPressed: () {
                navigatorKey.currentState.pushNamed('/register');
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.red),
              ),
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            ),
          ],
        ),
      ),
    );
  }
}
