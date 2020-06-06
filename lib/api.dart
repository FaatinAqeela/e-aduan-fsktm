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

  static String lihataduandisemak() {
    return "$url/lihataduandisemak.php";
  }

  static String lihataduanselesai() {
    return "$url/lihataduanselesai.php";
  }

  static String lihataduantidakselesai() {
    return "$url/lihataduantidakselesai.php";
  }

  static String gambar() {
    return "$url/aduanimages/";
  }
}
