class ResponseDetection {
  List<Outputs>? outputs;

  ResponseDetection({this.outputs});

  ResponseDetection.fromJson(Map<String, dynamic> json) {
    if (json['outputs'] != null) {
      outputs = <Outputs>[];
      json['outputs'].forEach((v) {
        outputs!.add(Outputs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (outputs != null) {
      data['outputs'] = outputs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outputs {
  String? id;

  String? createdAt;
  Data? data;

  Outputs({this.id, this.createdAt, this.data});

  Outputs.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    createdAt = json['created_at'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> output = <String, dynamic>{};
    output['id'] = id;
    output['created_at'] = createdAt;
    if (data != null) {
      output['data'] = data!.toJson();
    }
    return output;
  }
}

class Data {
  List<Regions>? regions;

  Data({this.regions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  String? id;
  Detection? data;
  double? value;

  Regions({this.id, this.data, this.value});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    data = json['data'] != null ? Detection.fromJson(json['data']) : null;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['value'] = value;
    return data;
  }
}

class Detection {
  List<Concepts>? concepts;

  Detection({this.concepts});

  Detection.fromJson(Map<String, dynamic> json) {
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach(
        (v) {
          concepts!.add(Concepts.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (concepts != null) {
      data['concepts'] = concepts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Concepts {
  String? id;
  String? name;
  double? value;
  String? appId;

  Concepts({this.id, this.name, this.value, this.appId});

  Concepts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    appId = json['app_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['app_id'] = appId;
    return data;
  }
}
