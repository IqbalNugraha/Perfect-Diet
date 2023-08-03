class ResponseValidate {
  List<Outputs>? outputs;

  ResponseValidate({this.outputs});

  ResponseValidate.fromJson(Map<String, dynamic> json) {
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
  Data? data;

  Outputs({this.data});

  Outputs.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Concepts>? concepts;

  Data({this.concepts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['concepts'] != null) {
      concepts = <Concepts>[];
      json['concepts'].forEach((v) {
        concepts!.add(Concepts.fromJson(v));
      });
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

  Concepts({
    this.id,
    this.name,
    this.value,
    this.appId,
  });

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
