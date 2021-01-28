import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:MacroTrack/services/store.dart';
import 'package:MacroTrack/services/api.dart';
import 'package:MacroTrack/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<StatefulWidget> {
  SharedPreferences prefs;

  var token = '';
  var userId = '';

  var user;

  @override
  void initState() {
    super.initState();

    getSavedCredentials();
  }

  void getSavedCredentials() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('userId');

    if (token != null || userId != null) {
      await login();
      navigatorKey.currentState.pushNamed('/home');
    } else {
      navigatorKey.currentState.pushNamed('/login');
    }
  }

  login() async {
    user = await Api.getUser(userId, token);
    Provider.of<Store>(context, listen: false).setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 75),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
