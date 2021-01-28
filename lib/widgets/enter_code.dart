import 'package:MacroTrack/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MacroTrack/utils/constants.dart';

class EnterCode extends StatefulWidget {
  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  SharedPreferences prefs;

  var code = '';

  @override
  void initState() {
    super.initState();
  }

  void onSubmit(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();

    var email = prefs.getString('email');
    var loginModel = await Api.getUserLogin(email, code);
    var user = await Api.getUser(loginModel.userId, loginModel.token);

    prefs.setString('userId', loginModel.userId);
    prefs.setString('token', loginModel.token);

    Provider.of<Store>(context, listen: false).setLogin(loginModel);
    Provider.of<Store>(context, listen: false).setUser(user);

    navigatorKey.currentState.pushNamed('/home');
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
                    code = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Code",
                  hintText: "Code",
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
                onSubmit(context);
              },
              child: Text('Submit'),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            ),
            FlatButton(
              onPressed: () {
                navigatorKey.currentState.pop();
              },
              child: Text(
                'go back',
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
