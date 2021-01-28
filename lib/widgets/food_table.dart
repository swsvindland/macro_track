import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MacroTrack/widgets/food_table_desktop.dart';
import 'package:MacroTrack/widgets/food_table_mobile.dart';
import 'package:MacroTrack/services/store.dart';
import 'package:MacroTrack/services/api.dart';


class FoodTable extends StatefulWidget {
  FoodTable({Key key}) : super(key: key);

  @override
  _FoodTable createState() => new _FoodTable();
}

class _FoodTable extends State<FoodTable> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 500
        ? FoodTableDesktop()
        : FoodTableMobile();
  }
}
