class ResponseDataRekomendasi {
  List<RekomendasiBreakfast>? result;
  String? message;

  ResponseDataRekomendasi({
    this.result,
    this.message,
  });

  ResponseDataRekomendasi.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      result = <RekomendasiBreakfast>[];
      json['results'].forEach((v) {
        result!.add(RekomendasiBreakfast.fromJson(v));
      });
    }
    if (json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['results'] = result!.map((v) => v.toJson()).toList();
    }
    if (message != null) {
      data['message'] = message;
    }
    return data;
  }
}

class RekomendasiBreakfast {
  int? id;
  String? title;
  String? image;
  ListNutrisi? nutrition;

  RekomendasiBreakfast({
    this.id,
    this.image,
    this.title,
    this.nutrition,
  });

  RekomendasiBreakfast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    nutrition = json['nutrition'] != null
        ? ListNutrisi.fromJson(json['nutrition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    if (nutrition != null) {
      data['nutrition'] = nutrition!.toJson();
    }
    return data;
  }
}

class ListNutrisi {
  List<Nutrisi>? nutrients;

  ListNutrisi({this.nutrients});

  ListNutrisi.fromJson(Map<String, dynamic> json) {
    if (json['nutrients'] != null) {
      nutrients = <Nutrisi>[];
      json['nutrients'].forEach((v) {
        nutrients!.add(Nutrisi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nutrients != null) {
      data['nutrients'] = nutrients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutrisi {
  double? amount;

  Nutrisi({this.amount});

  Nutrisi.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    return data;
  }
}
