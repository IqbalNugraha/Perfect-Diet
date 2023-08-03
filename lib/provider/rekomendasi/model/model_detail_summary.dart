class ResponseDetailSummary {
  String? summary;
  List<String>? dishType;
  List<String>? diet;
  List<String>? cuisines;
  String? message;
  WinePairing? winePairing;
  List<ExtendedIngredients>? extendedIngredients;

  ResponseDetailSummary({
    this.cuisines,
    this.diet,
    this.dishType,
    this.summary,
    this.message,
    this.winePairing,
    this.extendedIngredients,
  });

  ResponseDetailSummary.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    dishType = json["dishTypes"] == null
        ? []
        : List<String>.from(
            json["dishTypes"].map((x) => x),
          );
    diet = json["diets"] == null
        ? []
        : List<String>.from(
            json["diets"].map((x) => x),
          );
    cuisines = json["cuisines"] == null
        ? []
        : List<String>.from(
            json["cuisines"].map((x) => x),
          );
    if (json['message'] != null) {
      message = json['message'];
    }
    winePairing = json['winePairing'] != null
        ? WinePairing.fromJson(json['winePairing'])
        : null;
    if (json['extendedIngredients'] != null) {
      extendedIngredients = <ExtendedIngredients>[];
      json['extendedIngredients'].forEach((v) {
        extendedIngredients!.add(ExtendedIngredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary'] = summary;
    data['cuisines'] = cuisines;
    data['dishTypes'] = dishType;
    data['diets'] = diet;
    if (message != null) {
      data['message'] = message;
    }
    if (winePairing != null) {
      data['winePairing'] = winePairing!.toJson();
    }
    if (extendedIngredients != null) {
      data['extendedIngredients'] =
          extendedIngredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WinePairing {
  List<ProductMatches>? productMatches;

  WinePairing({this.productMatches});

  WinePairing.fromJson(Map<String, dynamic> json) {
    if (json['productMatches'] != null) {
      productMatches = <ProductMatches>[];
      json['productMatches'].forEach((v) {
        productMatches!.add(ProductMatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productMatches != null) {
      data['productMatches'] = productMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtendedIngredients {
  int? id;
  String? name;

  ExtendedIngredients({
    this.id,
    this.name,
  });

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProductMatches {
  int? id;
  String? title;
  String? description;
  String? price;
  String? imageUrl;
  double? averageRating;
  double? score;
  String? link;

  ProductMatches(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.averageRating,
      this.score,
      this.link});

  ProductMatches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    averageRating = json['averageRating'];
    score = json['score'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['imageUrl'] = imageUrl;
    data['averageRating'] = averageRating;
    data['score'] = score;
    data['link'] = link;
    return data;
  }
}
