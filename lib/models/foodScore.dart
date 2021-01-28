class FoodScore {
  final int calories;
  final int protein;
  final int fat;
  final int carbs;
  final int alcohol;
  final int fiber;

  FoodScore(
      {this.calories,
      this.protein,
      this.fat,
      this.carbs,
      this.alcohol,
      this.fiber});

  factory FoodScore.fromJson(Map<String, dynamic> json) {
    return FoodScore(
        calories: json['calories'],
        protein: json['protein'],
        fat: json['fat'],
        carbs: json['carbs'],
        alcohol: json['alcohol'],
        fiber: json['fiber']
    );
  }
}
