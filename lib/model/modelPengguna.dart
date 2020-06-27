class Pengguna {
  final String id_pengguna;
  final String namapenuh;
  final String nombortelefon;
  final String jabatan;
  final String katalaluan;
  final String kategoripengguna;
  final String gambarpengguna;

  Pengguna({
    this.id_pengguna,
    this.namapenuh,
    this.nombortelefon,
    this.jabatan,
    this.katalaluan,
    this.kategoripengguna,
    this.gambarpengguna,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id_pengguna: json['id_pengguna'],
      namapenuh: json['namapenuh'],
      nombortelefon: json['nombortelefon'],
      jabatan: json['jabatan'],
      katalaluan: json['katalaluan'],
      kategoripengguna: json['kategoripengguna'],
      gambarpengguna: json['gambarpengguna'],
    );
  }
}
