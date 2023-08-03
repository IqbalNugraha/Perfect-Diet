class PolaMakan {
  double? sarapan;
  double? makanSiang;
  double? makanMalam;
  double? ngemil;

  PolaMakan({
    this.sarapan,
    this.makanSiang,
    this.makanMalam,
    this.ngemil,
  });

  PolaMakan.fromJson(Map<String, dynamic> json) {
    sarapan = json['sarapan'];
    makanSiang = json['makan_siang'];
    makanMalam = json['makan_malam'];
    ngemil = json['ngemil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sarapan'] = sarapan;
    data['makan_siang'] = makanSiang;
    data['makan_malam'] = makanMalam;
    data['ngemil'] = ngemil;
    return data;
  }
}

class TablePolaMakan {
  int? sarapan;
  int? makanSiang;
  int? makanMalam;
  int? ngemil;
  int? carb;
  int? fat;  
  double? ngemilValue;

  TablePolaMakan({
    this.sarapan,
    this.makanSiang,
    this.makanMalam,
    this.ngemil,
    this.carb,
    this.fat,
    this.ngemilValue,
  });

  TablePolaMakan.fromJson(Map<String, dynamic> json) {
    sarapan = json['sarapan'];
    makanSiang = json['makan_siang'];
    makanMalam = json['makan_malam'];
    ngemil = json['ngemil'];
    ngemilValue = json['ngemil_value'];
    carb = json['carb'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sarapan'] = sarapan;
    data['makan_siang'] = makanSiang;
    data['makan_malam'] = makanMalam;
    data['ngemil'] = ngemil;
    data['ngemil_value'] = ngemilValue;
    data['carb'] = carb;
    data['fat'] = fat;
    return data;
  }
}

class NutrisiPolaMakan {
  int? cal;
  int? carb;
  int? fat;

  NutrisiPolaMakan({
    this.cal,
    this.carb,
    this.fat,
  });

  NutrisiPolaMakan.fromJson(Map<String, dynamic> json) {
    cal = json['cal'];    
    carb = json['carb'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cal'] = cal;
    data['carb'] = carb;
    data['fat'] = fat;
    return data;
  }
}

class ResponseListTable {
  List<ListTablePola>? listTablePolaMakan;

  ResponseListTable({this.listTablePolaMakan});

  ResponseListTable.fromJson(Map<String, dynamic> json) {
    if (json['list_table_pola_makan'] != null) {
      listTablePolaMakan = <ListTablePola>[];
      json['list_table_pola_makan'].forEach((v) {
        listTablePolaMakan!.add(ListTablePola.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listTablePolaMakan != null) {
      data['list_table_pola_makan'] =
          listTablePolaMakan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListTablePola {
  String? imtValue;
  int? sarapan;
  int? makanSiang;
  int? makanMalam;
  int? ngemil;

  ListTablePola({
    this.sarapan,
    this.makanSiang,
    this.makanMalam,
    this.ngemil,
    this.imtValue,
  });

  ListTablePola.fromJson(Map<String, dynamic> json) {
    sarapan = json['sarapan'];
    makanSiang = json['makan_siang'];
    makanMalam = json['makan_malam'];
    ngemil = json['ngemil'];
    imtValue = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sarapan'] = sarapan;
    data['makan_siang'] = makanSiang;
    data['makan_malam'] = makanMalam;
    data['ngemil'] = ngemil;
    data['value'] = imtValue;
    return data;
  }
}
