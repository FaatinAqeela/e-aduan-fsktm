import 'dart:convert';
import 'package:eaduanfsktm/api.dart';
import 'package:http/http.dart' as http;
import 'package:eaduanfsktm/model/modelRuangFasiliti.dart';

class RuangFasilitiServices {
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_ACTION = 'ADD';
  static const _UPDATE_ACTION = 'UPDATE';
  static const _DELETE_ACTION = 'DELETE';

//   static Future<String> tambahruangfasiliti(
//       String ruang_id, String fasiliti_id) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _ADD_ACTION;
//       map['ruang_id'] = ruang_id;
//       map['fasiliti_id'] = fasiliti_id;
//       final response = await http.post(BaseUrl.ruangfasiliti(), body: map);
//       print('Tambah ruang Response: ${response.body}');
//       if (200 == response.statusCode) {
//         return response.body;
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return "error";
//     }
//   }

//   static Future<List<RuangFasiliti>> getRuangFasiliti() async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _GET_ALL_ACTION;
//       final response = await http.post(BaseUrl.ruangfasiliti(), body: map);
//       print('get Fasiliti Response: ${response.body}');
//       if (200 == response.statusCode) {
//         List<RuangFasiliti> list = parseResponse(response.body);
//         return list;
//       } else {
//         return List<RuangFasiliti>();
//       }
//     } catch (e) {
//       return List<RuangFasiliti>(); // return an empty list on exception/error
//     }
//   }

//   static List<RuangFasiliti> parseResponse(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed
//         .map<RuangFasiliti>((json) => RuangFasiliti.fromJson(json))
//         .toList();
//   }

//   //Method to update an Employee in Database...
//   static Future<String> updateRuangFasiliti(String ruang_id, String fasiliti_id) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _UPDATE_ACTION;
//       map['ruang_id'] = ruang_id;
//       map['fasiliti_id'] = fasiliti_id;
      
//       final response = await http.post(BaseUrl.ruang(), body: map);
//       print('update Ruang Fasiliti Response: ${response.body}');
//       if (200 == response.statusCode) {
//         return response.body;
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return "error";
//     }
//   }

//  // Method to Delete an Employee from Database...
//   static Future<String> deleteRuangFasiliti(String ruangfasiliti_id) async {
//     try {
//       var map = Map<String, dynamic>();
//       map['action'] = _DELETE_ACTION;
//       map['ruangfasiliti_id'] = ruangfasiliti_id;
//       final response = await http.post(BaseUrl.ruang(), body: map);
//       print('deleteRuangFasiliti Response: ${response.body}');
//       if (200 == response.statusCode) {
//         return response.body;
//       } else {
//         return "error";
//       }
//     } catch (e) {
//       return "error"; // returning just an "error" string to keep this simple...
//     }
//   }
}
