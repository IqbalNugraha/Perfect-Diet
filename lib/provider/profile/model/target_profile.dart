class ResponseData {}

class TargetProfile {
  double? calories;
  double? caloriesDiet;
  double? carb;
  int? fat;
  String? weight;
  int? day;

  TargetProfile({
    this.day,
    this.calories,
    this.weight,
    this.carb,
    this.fat,
    this.caloriesDiet,
  });

  TargetProfile.fromJson(Map<String, dynamic> json) {
    day = json['hari'];
    weight = json['berat_badan'];
    calories = json['kalori'];
    caloriesDiet = json['kalori_diet'];
    fat = json['lemak'];
    carb = json['karbo'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['hari'] = day;
    data['berat_badan'] = weight;
    data['kalori'] = calories;
    data['kalori_diet'] = caloriesDiet;
    data['lemak'] = fat;
    data['karbo'] = carb;
    return data;
  }
}
