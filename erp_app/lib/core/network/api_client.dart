import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final http.Client client;
  ApiClient(this.client);

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final response = await client.post(
      Uri.parse(url),
      headers: const {
        'authorization':
        'Bearer 0KO4aoZA7V94zXa99uFCsz1F6AoY9O9a76nM3rtWMa6AyKOasbvoOgIsOESn6mXVj7nEktdHX6tD0814UY1LwhR73jcqdsNhjSo9tWY702ilEJ8wSLLbwP1F59wgj22A',
        'content-type': 'application/json'
      },
      body: jsonEncode(body), // ← این باید ورودی تابع باشد
    );


    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Server Error ${response.statusCode}');
  }
}
