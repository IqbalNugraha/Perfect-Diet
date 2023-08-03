class BatasKandungan {
  int? batasSarapan, batasMakanSiang, batasMakanMalam, batasCamilan;

  BatasKandungan({
    this.batasCamilan,
    this.batasMakanMalam,
    this.batasMakanSiang,
    this.batasSarapan,
  });

  BatasKandungan.fromJson(Map<String, dynamic> json) {
    batasSarapan = json['batas_sarapan'];
    batasMakanSiang = json['batas_makan_siang'];
    batasMakanMalam = json['batas_makan_malam'];
    batasCamilan = json['batas_camilan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batas_sarapan'] = batasSarapan;
    data['batas_makan_siang'] = batasMakanSiang;
    data['batas_makan_malam'] = batasMakanMalam;
    data['batas_camilan'] = batasCamilan;
    return data;
  }
}
