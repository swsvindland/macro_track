import 'dart:convert';
import 'package:MacroTrack/models/loginModel.dart';
import 'package:MacroTrack/models/userFood.dart';
import 'package:http/http.dart' as http;
import '../models/food.dart';
import '../models/foodScore.dart';
import '../models/user.dart';

const String BASE_URL = 'http://10.0.2.2:5001';
//const String BASE_URL = 'http://localhost:5001';

class Api {
  static Future sendLoginCode(String email) async {
    final body = '{"email": "$email"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    await http.post(BASE_URL + '/users/sendLoginCode',
        headers: headers, body: body);
  }

  static Future<LoginModel> getUserLogin(String email, String code) async {
    final body = '{"email": "$email", "code": "$code"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/users/getUserLogin',
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<User> getUser(String userId, String token) async {
    final body = '{"userId": "$userId", "token": "$token"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/users/getUser',
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<User> register(
      String name, String email, String password) async {
    final body =
        '{"name": "$name",  "email": "$email", "password": "$password"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/users/addUser',
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<FoodList> fetchAllFoods() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    final response =
        await http.get(BASE_URL + '/foods/getAllFoods', headers: headers);

    if (response.statusCode == 200) {
      return FoodList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<FoodList> fetchFood(String userId) async {
    final body =
        '{"userId": "$userId", "date": "${new DateTime.now().toIso8601String()}"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/foods/getUserFoods',
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return FoodList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<FoodScore> fetchUserFoodScore(String userId) async {
    final body =
        '{"userId": "$userId" , "date": "${new DateTime.now().toIso8601String()}"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/foods/getUserFoodScore',
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return FoodScore.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future addUserFood(String userId, List<Food> foods) async {
    var userFoods = foods.map((value) {
      var userFood = new UserFood();
      userFood.foodId = value.id;
      userFood.servings = value.servings;
      return userFood;
    }).toList();

    var jsonUserFoods = new UserFood().toStringArray(userFoods);

    final body =
        '{"userId": "$userId", "userFoods": $jsonUserFoods, "created": "${new DateTime.now().toIso8601String()}"}';

    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/foods/addUserFood',
        headers: headers, body: body);

    if (response.statusCode == 202) {
      return null;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future updateUserFood(String userId, Food food) async {
    var userFood = new UserFood();
    userFood.foodId = food.id;
    userFood.servings = food.servings;
    ;

    final body =
        '{"userId": "$userId", "userFood": ${userFood.toJson(userFood)}, "updated": "${new DateTime.now().toIso8601String()}"}';

    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/foods/updateUserFood',
        headers: headers, body: body);

    if (response.statusCode == 202) {
      return null;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future addFood(
      String name,
      String brand,
      int servingSize,
      int calories,
      int protein,
      int fat,
      int carbs,
      int alcohol,
      int fiber) async {
    final body =
        '{"name": "$name", "brand": "$brand", "servingSize": $servingSize, "calories": $calories, "protein": $protein, "fat": $fat, "carbs": $carbs, "alcohol": $alcohol, "fiber": $fiber}';

    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.post(BASE_URL + '/foods/addFood',
        headers: headers, body: body);

    if (response.statusCode == 202) {
      return null;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
