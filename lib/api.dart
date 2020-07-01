class BaseUrl {
  static String url = "http://172.20.10.3/E-Aduan";
  //static String url = "https://e-aduanfsktm.000webhostapp.com";

  static String logmasuk() {
    return "$url/logmasuk.php";
  }

  static String tambahaduan() {
    return "$url/tambahaduan.php";
  }

  static String lihatpengguna(String idpengguna) {
    return "$url/lihatpengguna.php?idpengguna=$idpengguna";
  }

  static String lihatruangfasiliti(String barcode) {
    return "$url/lihatruangfasiliti.php?kod=$barcode";
  }

  static String lihataduandisemak(String idpengguna) {
    return "$url/lihataduandisemak.php?idpengguna=$idpengguna";
  }

  static String lihataduanselesai(String idpengguna) {
    return "$url/lihataduanselesai.php?idpengguna=$idpengguna";
  }

  static String lihataduantidakselesai(String idpengguna) {
    return "$url/lihataduantidakselesai.php?idpengguna=$idpengguna";
  }

  static String gambarprofil() {
    return "$url/gambarprofile/";
  }

  static String gambar() {
    return "$url/aduanimages/";
  }

  static String kemaskinistatus() {
    return "$url/kemaskinistatusaduan.php";
  }

  static String senaraiaduandisemak(String idjuruteknik) {
    return "$url/senaraiaduandisemak.php?idjuruteknik=$idjuruteknik";
  }

  static String senaraiaduanselesai(String idjuruteknik) {
    return "$url/senaraiaduanselesai.php?idjuruteknik=$idjuruteknik";
  }

  static String senaraiaduantidakselesai(String idjuruteknik) {
    return "$url/senaraiaduantidakselesai.php?idjuruteknik=$idjuruteknik";
  }

  static String tukarkatalaluan(String idpengguna) {
    return "$url/tukarkatalaluan.php?idpengguna=$idpengguna";
  }

  static String ruang() {
    return "$url/ruang.php";
  }

  static String juruteknik() {
    return "$url/juruteknik.php";
  }

  static String lihatjuruteknik() {
    return "$url/lihatjuruteknik.php";
  }

  static String lihatruang() {
    return "$url/lihatruang.php";
  }

  static String ruangfasiliti(String ruangid) {
    return "$url/ruangfasiliti.php?ruangid=$ruangid";
  }

  static String fasiliti() {
    return "$url/fasiliti.php?";
  }
}
