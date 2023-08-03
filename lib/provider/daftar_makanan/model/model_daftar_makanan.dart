class ResponseData {
  List<ModelListFood>? listFood;

  ResponseData({
    this.listFood,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json[''] != null) {
      listFood = <ModelListFood>[];
      json[''].forEach((v) {
        listFood?.add(ModelListFood.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listFood != null) {
      data[''] = listFood;
    }
    return data;
  }
}

class ModelListFood {
  int? id;
  String? title;
  String? img;
  int? calories;
  String? fat;
  String? carbs;

  ModelListFood({
    this.id,
    this.title,
    this.calories,
    this.carbs,
    this.fat,
    this.img,
  });

  ModelListFood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    img = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['calories'] = calories;
    data['carbs'] = carbs;
    data['fat'] = fat;
    data['image'] = img;
    return data;
  }
}
