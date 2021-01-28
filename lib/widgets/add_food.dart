import 'package:MacroTrack/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/store.dart';
import '../services/api.dart';
import '../models/food.dart';

class AddFood extends StatefulWidget {
  AddFood({Key key}) : super(key: key);

  @override
  _AddFood createState() => new _AddFood();
}

class _AddFood extends State<AddFood> {
  TextEditingController editingController = TextEditingController();

  Future<FoodList> foods;
  var items = List<Food>();
  var allItems = List<Food>();

  @override
  void initState() {
    super.initState();
    foods = Api.fetchAllFoods();
  }

  void filterSearchResults(String query) {
    List<Food> dummySearchList = List<Food>();
    dummySearchList.addAll(allItems);
    if (query.isNotEmpty) {
      List<Food> dummyListData = List<Food>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.brand.toLowerCase().contains(query.toLowerCase()) ||
            item.servings > 0) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(allItems);
      });
    }
  }

  createFoodDialog(BuildContext context, Food food) {
    int servings = 1;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 400,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(food.name),
                    Text(food.brand),
                    Text(food.servingSize.toString()),
                    TextField(
                      decoration:
                          new InputDecoration(labelText: "Enter your number"),
                      keyboardType: TextInputType.number,
                      onChanged: ((value) {
                        setState(() {
                          servings = int.parse(value);
                        });
                      }),
                    ),
                    Text((servings * food.calories).toString()),
                    Text((servings * food.protein).toString()),
                    Text((servings * food.fat).toString()),
                    Text((servings * food.carbs).toString()),
                    RaisedButton(
                        onPressed: () {
                          food.servings = servings;
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text('Select'))
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

    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width > 500
                  ? MediaQuery.of(context).size.width * .85
                  : MediaQuery.of(context).size.width * .95,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Card(
                child: FutureBuilder<FoodList>(
                  future: foods,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          width: MediaQuery.of(context).size.width > 500
                              ? MediaQuery.of(context).size.width * .85
                              : MediaQuery.of(context).size.width * .95,
                          height: MediaQuery.of(context).size.height * 0.90,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      if (snapshot.hasError)
                        return Container(
                            width: MediaQuery.of(context).size.width > 500
                                ? MediaQuery.of(context).size.width * .85
                                : MediaQuery.of(context).size.width * .95,
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: Center(
                                child: Text('Error: ${snapshot.error}')));
                      else {
                        allItems = snapshot.data.foods;
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  filterSearchResults(value);
                                },
                                controller: editingController,
                                decoration: InputDecoration(
                                    labelText: "Search",
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)))),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(
                                          '${items[index].name} \t calories: ${items[index].calories * (items[index].servings == 0 ? 1 : items[index].servings)}'),
                                      subtitle: Text(
                                          '${items[index].brand} \t  serving size: ${items[index].servingSize * (items[index].servings == 0 ? 1 : items[index].servings)}'),
                                      onTap: () {
//                                        createFoodDialog(context, items[index]);
//                                    selectedItems.add(items[index]);
                                      },
                                      trailing: Container(
                                        width: 120,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                                's: ${items[index].servings ?? 0}'),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              tooltip: 'Add Food Serving',
                                              onPressed: () {
                                                setState(() {
                                                  items[index].servings++;
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              tooltip: 'Add Food Serving',
                                              onPressed: () {
                                                setState(() {
                                                  items[index].servings > 0
                                                      ? items[index].servings--
                                                      : 0;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                onPressed: () async {
                                  store.setUpdating(true);
                                  await Api.addUserFood(store.user.id, items);
                                  store.setUpdating(false);

                                  navigatorKey.currentState.pushNamed('/home');
                                },
                                child: Text('Add'),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}