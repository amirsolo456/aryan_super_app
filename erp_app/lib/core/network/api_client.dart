//
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../local_storge/getToken.dart';
//
// class ApiClient {
//   final http.Client client;
//   ApiClient(this.client);
//
//   Future<dynamic> post(String url, Map<String, dynamic> body) async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedJson = prefs.getString("user_token");
//     print(savedJson.toString());
//
//     if (savedJson == null) {
//       throw Exception("توکن نا معتبر");
//     }
//
//     final tokenMap = jsonDecode(savedJson);
//
//     final token = tokenMap["accessToken"];
//
//     final response = await client.post(
//       Uri.parse(url),
//       headers: {
//         'authorization': 'Bearer $token',
//         'content-type': 'application/json',
//       },
//       body: jsonEncode(body),
//     );
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     }
//
//     throw Exception('Server Error ${response.statusCode}');
//   }
// }
//
//
//
//
// // class ApiClient {
// //   final http.Client client;
// //   ApiClient(this.client);
// //
// //   Future<dynamic> post(String url, Map<String, dynamic> body) async {
// //     final response = await client.post(
// //       Uri.parse(url),
// //       headers: const {
// //         'authorization':
// //         'Bearer O5oEiCT8BU4N9H9bql1SlIKFp76435siJCvwy1OLPXqhRtG7HBu5LuZ3k0vMDOdIXF77MWq7oZXdNejwF1m15HXCQXt36EwoYZ1352kB4bjq8Ia54xaX88ba54m978rw',
// //         'content-type': 'application/json'
// //       },
// //       body: jsonEncode(body), // ← این باید ورودی تابع باشد
// //     );
// //
// //
// //     if (response.statusCode == 200) {
// //       return jsonDecode(response.body);
// //     }
// //
// //     throw Exception('Server Error ${response.statusCode}');
// //   }
// // }
