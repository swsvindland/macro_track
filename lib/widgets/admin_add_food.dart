import 'package:MacroTrack/services/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';

class AdminAddFood extends StatefulWidget {
  AdminAddFood({Key key}) : super(key: key);

  @override
  _AdminAddFood createState() => new _AdminAddFood();
}

class _AdminAddFood extends State<AdminAddFood> {
  var name = '';
  var brand = '';
  var servingSize = 0;
  var calories = 0;
  var protein = 0;
  var fat = 0;
  var carbs = 0;
  var alcohol = 0;
  var fiber = 0;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return new Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 500
              ? MediaQuery.of(context).size.width * .85
              : MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * 0.95,
          child: Card(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value.toString();
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Name",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          brand = value.toString();
                        },
                        decoration: InputDecoration(
                            labelText: "Brand",
                            hintText: "Brand",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          servingSize = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ], // Only
                        decoration: InputDecoration(
                            labelText: "Serving Size (g)",
                            hintText: "Serving Size (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          calories = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Caloires (g)",
                            hintText: "Calories (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          protein = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Protein (g)",
                            hintText: "Protein (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          fat = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Fat (g)",
                            hintText: "Fat (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          carbs = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Carbs (g)",
                            hintText: "Carbs (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          carbs = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Alcohol (g)",
                            hintText: "Alcohol (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          fiber = int.tryParse(value);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Fiber (g)",
                            hintText: "Fiber (g)",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: RaisedButton(
                        onPressed: () async {
                          store.setUpdating(true);
                          await Api.addFood(name, brand, servingSize, calories,
                              protein, fat, carbs, alcohol, fiber);
                          store.setUpdating(false);
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
