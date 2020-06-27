class Fasiliti {
  String fasiliti_id;
  String namafasiliti;

  Fasiliti({
    this.fasiliti_id,
    this.namafasiliti,
  });

  factory Fasiliti.fromJson(Map<String, dynamic> json) {
    return Fasiliti(
      fasiliti_id: json['fasiliti_id'] as String,
      namafasiliti: json['namafasiliti'] as String,
    );
  }
}
