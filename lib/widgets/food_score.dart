import 'package:MacroTrack/models/foodScore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/store.dart';
import '../services/api.dart';

class FoodScoreCard extends StatefulWidget {
  FoodScoreCard({Key key}) : super(key: key);

  @override
  _FoodScoreCard createState() => new _FoodScoreCard();
}

class _FoodScoreCard extends State<FoodScoreCard> {

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    return Container(
      width: MediaQuery.of(context).size.width > 500
          ? MediaQuery.of(context).size.width * .85
          : MediaQuery.of(context).size.width * .93,
      height: MediaQuery.of(context).size.height * 0.10,
      child: FutureBuilder<FoodScore>(
        future: Api.fetchUserFoodScore(store.user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Calories: ' +
                          snapshot.data.calories.toString() +
                          ' cal'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Protein: ' +
                          snapshot.data.protein.toString() +
                          ' g'),
                      Text('Fat: ' + snapshot.data.fat.toString() + ' g'),
                      Text('Carbs: ' + snapshot.data.carbs.toString() + ' g'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Alcohol: ' +
                          snapshot.data.alcohol.toString() +
                          ' g'),
                      Text('Fiber: ' + snapshot.data.fiber.toString() + ' g'),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
