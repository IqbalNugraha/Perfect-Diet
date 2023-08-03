class ListSaved {
  String? imgUrl;
  int? kalori;
  int? karbo;
  int? lemak;
  String? title;

  ListSaved({
    this.imgUrl,
    this.kalori,
    this.karbo,
    this.lemak,
    this.title,
  });

  ListSaved.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    kalori = json['kalori'];
    karbo = json['karbo'];
    lemak = json['lemak'];
    title = json['nama_makanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgUrl'] = imgUrl;    
    data['kalori'] = kalori;
    data['karbo'] = karbo;
    data['lemak'] = lemak;
    data['nama_makanan'] = title;
    return data;
  }
}
