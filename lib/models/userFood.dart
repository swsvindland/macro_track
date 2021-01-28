class UserFood {
  int foodId;
  int servings;

  UserFood({this.foodId, this.servings});

  String toJson(UserFood userFood) {
    return '{"foodId": ${userFood.foodId}, "servings": ${userFood.servings}}';
  }

  List<String> toStringArray(List<UserFood> userFoods) {
    var userFoodsList = new List<String>();

    userFoods.forEach((value) => {
          userFoodsList
              .add('{"foodId": ${value.foodId}, "servings": ${value.servings}}')
        });

    return userFoodsList;
  }
}
