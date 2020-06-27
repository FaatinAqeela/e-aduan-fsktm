class Ruang {
  String ruangid;
  String namaruang;
  String lokasi;
  String aras;
  String juruteknik_id;

  Ruang(
      {this.ruangid,
      this.namaruang,
      this.lokasi,
      this.aras,
      this.juruteknik_id});

  factory Ruang.fromJson(Map<String, dynamic> json) {
    return Ruang(
      ruangid: json['ruangid'] as String,
      namaruang: json['namaruang'] as String,
      lokasi: json['lokasi'] as String,
      aras: json['aras'] as String,
      juruteknik_id: json['juruteknik_id'] as String,
    );
  }
}
