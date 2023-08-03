class History {
  String? namaMakanan;
  int? cal;
  int? fat;
  int? carb;
  String? imgUrl;

  History({
    this.namaMakanan,
    this.cal,
    this.fat,
    this.carb,
    this.imgUrl,
  });

  History.fromJson(Map<String, dynamic> json) {
    namaMakanan = json['nama_makanan'];
    cal = json['cal'];
    fat = json['fat'];
    carb = json['carb'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_makanan'] = namaMakanan;
    data['cal'] = cal;
    data['fat'] = fat;
    data['carb'] = carb;
    data['img_url'] = imgUrl;
    return data;
  }
}
