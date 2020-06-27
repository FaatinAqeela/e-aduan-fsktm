import 'dart:convert';
import 'package:eaduanfsktm/api.dart';

import 'package:http/http.dart' as http;
import 'package:eaduanfsktm/model/modelRuang.dart';
import 'package:eaduanfsktm/RuangFasilitiServices.dart';

class Services {
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  static Future<String> tambahruang(String namaruang, String lokasi,
      String aras, String juruteknik_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['namaruang'] = namaruang;
      map['lokasi'] = lokasi;
      map['aras'] = aras;
      map['juruteknik_id'] = juruteknik_id;
      final response = await http.post(BaseUrl.ruang(), body: map);
      print('Tambah ruang Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Ruang>> getRuang() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(BaseUrl.ruang(), body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Ruang> list = parseResponse(response.body);
        return list;
      } else {
        return List<Ruang>();
      }
    } catch (e) {
      return List<Ruang>(); // return an empty list on exception/error
    }
  }

  static List<Ruang> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ruang>((json) => Ruang.fromJson(json)).toList();
  }

  // Method to update an Employee in Database...
  static Future<String> updateRuang(String ruangid, String namaruang,
      String lokasi, String aras, String juruteknik_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['ruangid'] = ruangid;
      map['namaruang'] = namaruang;
      map['lokasi'] = lokasi;
      map['aras'] = aras;
      map['juruteknik_id'] = juruteknik_id;
      final response = await http.post(BaseUrl.ruang(), body: map);
      print('updateRuang Response: ${response.body}');
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
  static Future<String> deleteRuang(String ruangid) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['ruangid'] = ruangid;
      final response = await http.post(BaseUrl.ruang(), body: map);
      print('deleteRuang Response: ${response.body}');
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
