import 'package:eaduanfsktm/model/modelPengguna.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eaduanfsktm/api.dart';

class JuruteknikServices {
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_ACTION = 'ADD';
  static const _UPDATE_ACTION = 'UPDATE';
  static const _DELETE_ACTION = 'DELETE';

  static Future<String> tambahjuruteknik(String id_pengguna, String namapenuh,
      String nombortelefon, String jabatan) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ACTION;
      map['id_pengguna'] = id_pengguna;
      map['namapenuh'] = namapenuh;
      map['nombortelefon'] = nombortelefon;
      map['jabatan'] = jabatan;
      final response = await http.post(BaseUrl.juruteknik(), body: map);
      print('Tambah juruteknik Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Pengguna>> getJuruteknik() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(BaseUrl.juruteknik(), body: map);
      print('pengguna Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Pengguna> list = parsePengguna(response.body);
        return list;
      } else {
        return List<Pengguna>();
      }
    } catch (e) {
      return List<Pengguna>(); // return an empty list on exception/error
    }
  }

  static List<Pengguna> parsePengguna(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pengguna>((json) => Pengguna.fromJson(json)).toList();
  }

  // Method to update an Employee in Database...
  static Future<String> updateJuruteknik(String juruteknik_id, String namapenuh,
      String nombortelefon, String jabatan) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_ACTION;
      map['id_pengguna'] = juruteknik_id;
      map['namapenuh'] = namapenuh;
      map['nombortelefon'] = nombortelefon;
      map['jabatan'] = jabatan;

      final response = await http.post(BaseUrl.juruteknik(), body: map);
      print('update juruteknik Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteJuruteknik(String idpengguna) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['id_pengguna'] = idpengguna;
      final response = await http.post(BaseUrl.juruteknik(), body: map);
      print('delete juruteknik Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
