import 'dart:convert';
import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/model/modelFasiliti.dart';
import 'package:http/http.dart' as http;

class FasilitiServices {
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_ACTION = 'ADD';
  static const _UPDATE_ACTION = 'UPDATE';
  static const _DELETE_ACTION = 'DELETE';

  static Future<String> tambahfasiliti(String namafasiliti) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ACTION;
      map['namafasiliti'] = namafasiliti;

      final response = await http.post(BaseUrl.fasiliti(), body: map);
      print('Tambah fasiliti Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Fasiliti>> getFasiliti() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(BaseUrl.fasiliti(), body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Fasiliti> list = parseResponse(response.body);
        return list;
      } else {
        return List<Fasiliti>();
      }
    } catch (e) {
      return List<Fasiliti>(); // return an empty list on exception/error
    }
  }

  static List<Fasiliti> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Fasiliti>((json) => Fasiliti.fromJson(json)).toList();
  }

  // Method to update an Employee in Database...
  static Future<String> updateFasiliti(
      String fasiliti_id, String namafasiliti) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_ACTION;
      map['fasiliti_id'] = fasiliti_id;
      map['namafasiliti'] = namafasiliti;

      final response = await http.post(BaseUrl.fasiliti(), body: map);
      print('update fasiliti Response: ${response.body}');
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
  static Future<String> deleteFasiliti(String fasiliti_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACTION;
      map['fasiliti_id'] = fasiliti_id;
      final response = await http.post(BaseUrl.fasiliti(), body: map);
      print('delete Fasiliti Response: ${response.body}');
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
