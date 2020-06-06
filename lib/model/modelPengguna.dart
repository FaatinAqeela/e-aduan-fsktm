class Pengguna {
  final String idpengguna;
  final String namapenuh;
  final String nombortelefon;
  final String katalaluan;
  final String kategoripengguna;
  final String gambarpengguna;

  Pengguna({
    this.idpengguna,
    this.namapenuh,
    this.nombortelefon,
    this.katalaluan,
    this.kategoripengguna,
    this.gambarpengguna,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      idpengguna: json['id_pengguna'],
      namapenuh: json['namapenuh'],
      katalaluan: json['katalaluan'],
      kategoripengguna: json['kategoripengguna'],
      gambarpengguna: json['gambarpengguna'],
    );
  }
}
