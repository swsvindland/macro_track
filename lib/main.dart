import 'package:MacroTrack/widgets/add_food.dart';
import 'package:MacroTrack/widgets/admin_add_food.dart';
import 'package:MacroTrack/widgets/enter_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/splashscreen.dart';
import './widgets/home.dart';
import './widgets/login.dart';
import './widgets/register.dart';
import './services/store.dart';
import 'package:MacroTrack/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Store()),
      ],
      child: Consumer<Store>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            navigatorKey: navigatorKey,
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/login': (context) => Login(),
              '/enterCode': (context) => EnterCode(),
              '/register': (context) => Register(),
              '/home': (context) => App(),
              '/add-food': (context) => AddFood()
            },
          );
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Home(),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Navigation'),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text('Add Food'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminAddFood()),
              );
            },
          )
        ],
      ),
    );
  }
}
