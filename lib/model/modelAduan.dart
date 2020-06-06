class Aduan {
  final String aduan_id;
  final String tarikhaduan;
  final String ruang_id;
  final String fasiliti_id;
  final String maklumat;
  final String gambaraduan;
  final String status;
  final String idpengguna;
  final String namaruang;
  final String namafasiliti;
  final String alasan;

  Aduan({
    this.aduan_id,
    this.tarikhaduan,
    this.ruang_id,
    this.fasiliti_id,
    this.maklumat,
    this.gambaraduan,
    this.status,
    this.idpengguna,
    this.namaruang,
    this.namafasiliti,
    this.alasan,
  });

  factory Aduan.fromJson(Map<String, dynamic> json) {
    return Aduan(
      aduan_id: json['aduan_id'],
      tarikhaduan: json['tarikhaduan'],
      ruang_id: json['ruang_id'],
      fasiliti_id: json['fasiliti_id'],
      maklumat: json['maklumat'],
      gambaraduan: json['gambaraduan'],
      status: json['status'],
      idpengguna: json['idpengguna'],
      namaruang: json['namaruang'],
      namafasiliti: json['namafasiliti'],
      alasan: json['alasan'],
    );
  }
}
