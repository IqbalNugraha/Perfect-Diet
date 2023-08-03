class ImtProfile {
  double? bmrKalori;
  double? imt;
  double? imtLemak;
  String? hasilIMT;

  ImtProfile({
    this.bmrKalori,
    this.imt,
    this.imtLemak,
    this.hasilIMT,
  });

  ImtProfile.fromJson(Map<String, dynamic> json) {
    bmrKalori = json['bmrKalori'];
    imt = json['imt'];
    imtLemak = json['imtLemak'];
    hasilIMT = json['hasil_imt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bmrKalori'] = bmrKalori;
    data['imt'] = imt;
    data['imtLemak'] = imtLemak;
    data['hasil_imt'] = hasilIMT;
    return data;
  }
}
