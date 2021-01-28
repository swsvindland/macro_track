import 'package:MacroTrack/services/store.dart';
import 'package:MacroTrack/utils/constants.dart';
import 'package:MacroTrack/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './food_table.dart';
import './food_score.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return store.updating ? Loading() :
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new SizedBox(height: 25),
        new Text(
          '${new DateTime.now().year} / ${new DateTime.now().month} / ${new DateTime.now().day}',
          style: TextStyle(color: Colors.black38),
        ),
        new Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: FoodScoreCard(),
          ),
        ),
        new FoodTable(),
        new SizedBox(height: 5),
        new Container(
            height: 35,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "Add Food",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    navigatorKey.currentState.pushNamed('/add-food');
                  },
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  color: Colors.red,
                )
              ],
            )),
        new SizedBox(height: 5),
      ],
    );
  }
}
