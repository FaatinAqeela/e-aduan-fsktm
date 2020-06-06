class RuangFasiliti {
  final String ruangfasiliti_id;
  final String ruang_id;
  final String fasiliti_id;
  final String kuantiti;
  final String namaruang;
  final String namafasiliti;

  RuangFasiliti({
    this.ruangfasiliti_id,
    this.ruang_id,
    this.fasiliti_id,
    this.kuantiti,
    this.namaruang,
    this.namafasiliti,
  });

  factory RuangFasiliti.fromJson(Map<String, dynamic> json) {
    return RuangFasiliti(
      ruangfasiliti_id: json['ruangfasiliti_id'],
      ruang_id: json['ruang_id'],
      fasiliti_id: json['fasiliti_id'],
      kuantiti: json['kuantiti'],
      namaruang: json['namaruang'],
      namafasiliti: json['namafasiliti'],
    );
  }
}
