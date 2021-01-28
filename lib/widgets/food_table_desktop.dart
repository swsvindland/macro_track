import 'package:MacroTrack/models/food.dart';
import 'package:MacroTrack/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/store.dart';
import 'data_table.dart';

class FoodTableDesktop extends StatefulWidget {
  FoodTableDesktop({Key key}) : super(key: key);

  @override
  _FoodTableDesktop createState() => new _FoodTableDesktop();
}

class _FoodTableDesktop extends State<FoodTableDesktop> {
  createFoodDialog(BuildContext context, Food food) async {
    int servings = food.servings;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('name: \t ${food.name}'),
                  Text('brand: \t ${food.brand}'),
                  Text('servings: \t ${food.servings}'),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      onChanged: (value) {
                        servings = int.tryParse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Update Servings",
                          hintText: "Update Servings",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 100.0,
                      width: 180,
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        padding: const EdgeInsets.all(4.0),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        children: <Widget>[
                          Text(
                            'calories: ${servings * food.calories} g',
                            textAlign: TextAlign.center,
                          ),
                          Text('protein: ${servings * food.protein} g',
                              textAlign: TextAlign.center),
                          Text('fat: ${servings * food.fat} g',
                              textAlign: TextAlign.center),
                          Text('carbs: ${servings * food.carbs} g',
                              textAlign: TextAlign.center),
                          Text('alcohol: ${servings * food.alcohol} g',
                              textAlign: TextAlign.center),
                          Text('fiber: ${servings * food.fiber} g',
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pop(context, servings);
                      },
                      child: Text('Update'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return Container(
      width: MediaQuery.of(context).size.width * .85,
      height: MediaQuery.of(context).size.height * .70,
      child: Card(
        child: FutureBuilder<FoodList>(
          future: Api.fetchFood(store.user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: BoxlessDataTable(
                  columns: [
                    BoxlessDataColumn(label: Text("Name")),
                    BoxlessDataColumn(label: Text('Servings')),
                    BoxlessDataColumn(label: Text("Calories")),
                    BoxlessDataColumn(label: Text("Protein")),
                    BoxlessDataColumn(label: Text("Fat")),
                    BoxlessDataColumn(label: Text("Carbs")),
                  ],
                  rows: snapshot.data.foods.map((value) {
                    return BoxlessDataRow(
                        onSelectChanged: (bool selected) async {
                          if (selected) {
                            var servings =
                                await createFoodDialog(context, value);
                            if (servings != null) {
                              value.servings = servings;
                              store.setUpdating(true);
                              await Api.updateUserFood(store.user.id, value);
                              store.setUpdating(false);
                            }
                          }
                        },
                        cells: [
                          BoxlessDataCell(Text(value.name)),
                          BoxlessDataCell(Text(value.servings.toString())),
                          BoxlessDataCell(Text(value.calories.toString())),
                          BoxlessDataCell(Text(value.protein.toString())),
                          BoxlessDataCell(Text(value.fat.toString())),
                          BoxlessDataCell(Text(value.carbs.toString())),
                        ]);
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
