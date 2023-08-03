class Profile {
  String? aktivitas;
  String? nama;
  int? umur;
  int? tinggi;
  int? berat;

  Profile({
    this.aktivitas,
    this.berat,
    this.nama,
    this.tinggi,
    this.umur,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    aktivitas = json['aktivitas'];
    berat = json['berat_badan'];
    nama = json['nama'];
    tinggi = json['tinggi_badan'];
    umur = json['usia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aktivitas'] = aktivitas;
    data['berat_badan'] = berat;
    data['nama'] = nama;
    data['tinggi_badan'] = tinggi;
    data['usia'] = umur;
    return data;
  }
}
