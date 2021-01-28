class Food {
  final int id;
  int servings;
  final String name;
  final String brand;
  final int servingSize;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;
  final int alcohol;
  final int fiber;

  Food(
      {this.id,
        this.servings = 0,
      this.name,
      this.brand,
      this.servingSize = 0,
      this.calories = 0,
      this.protein = 0,
      this.fat = 0,
      this.carbs = 0,
      this.alcohol = 0,
      this.fiber = 0});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json['id'],
        servings: json['servings'] ?? 0,
        name: json['name'],
        brand: json['brand'],
        servingSize: json['servingSize'],
        calories: json['calories'],
        protein: json['protein'],
        fat: json['fat'],
        carbs: json['carbs'],
        alcohol: json['alcohol'],
        fiber: json['fiber']
    );
  }
}

class FoodList {
  final List<Food> foods;

  FoodList({this.foods});

  factory FoodList.fromJson(List<dynamic> parsedJson) {
    List<Food> foods = new List<Food>();
    foods = parsedJson.map((i) => Food.fromJson(i)).toList();

    return new FoodList(foods: foods);
  }
}
