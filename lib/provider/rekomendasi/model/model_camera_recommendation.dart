class ResponseDataCamera {
  Nutrition? nutrition;
  Category? category;

  ResponseDataCamera({
    this.nutrition,
    this.category,
  });

  ResponseDataCamera.fromJson(Map<String, dynamic> json) {
    nutrition = json['nutrition'] != null
        ? Nutrition.fromJson(json['nutrition'])
        : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Nutrition {
  int? recipesUsed;
  Calories? calories;
  Calories? fat;
  Calories? protein;
  Calories? carbs;

  Nutrition({
    this.recipesUsed,
    this.calories,
    this.fat,
    this.protein,
    this.carbs,
  });

  Nutrition.fromJson(Map<String, dynamic> json) {
    recipesUsed = json['recipesUsed'];
    calories =
        json['calories'] != null ? Calories.fromJson(json['calories']) : null;
    fat = json['fat'] != null ? Calories.fromJson(json['fat']) : null;
    protein =
        json['protein'] != null ? Calories.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? Calories.fromJson(json['carbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipesUsed'] = recipesUsed;
    if (calories != null) {
      data['calories'] = calories!.toJson();
    }
    if (fat != null) {
      data['fat'] = fat!.toJson();
    }
    if (protein != null) {
      data['protein'] = protein!.toJson();
    }
    if (carbs != null) {
      data['carbs'] = carbs!.toJson();
    }
    return data;
  }
}

class Calories {
  int? value;

  Calories({
    this.value,
  });

  Calories.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}

class Category {
  String? name;

  Category({
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
