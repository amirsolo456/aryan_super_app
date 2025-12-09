import 'dart:convert';

import 'package:http/http.dart' as http;

// مدل‌ها
class ToolbarRequest {
  // فیلدهای مدل Request
  Map<String, dynamic> toJson() {
    return {
      // تبدیل فیلدها به JSON
    };
  }
}

class ToolbarResponse {
  final String result;
  final ResponseData? data;

  ToolbarResponse({required this.result, this.data});

  factory ToolbarResponse.fromJson(Map<String, dynamic> json) {
    return ToolbarResponse(
      result: json['result'] ?? 'Failed',
      data: json['data'] != null ? ResponseData.fromJson(json['data']) : null,
    );
  }
}

class ResponseData {
  // فیلدهای ResponseData
  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData();
  }
}

// اینترفیس سرویس
abstract class IToolBarDataService {
  Future<ToolbarResponse?> get(ToolbarRequest request);
}

// پیاده‌سازی سرویس
class ToolBarDataService implements IToolBarDataService {
  final http.Client _client;
  final String _baseUrl;

  ToolBarDataService({required http.Client client, required String baseUrl})
    : _client = client,
      _baseUrl = baseUrl;

  @override
  Future<ToolbarResponse?> get(ToolbarRequest request) async {
    try {
      final url = Uri.parse('$_baseUrl/api/menu/gettoolbardata');

      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final toolbarResponse = ToolbarResponse.fromJson(responseData);

        if (toolbarResponse.result == 'Success' ||
            toolbarResponse.result == 'true') {
          return toolbarResponse;
        } else {
          return ToolbarResponse(result: 'Failed');
        }
      } else {
        return ToolbarResponse(result: 'Failed');
      }
    } catch (e) {
      return ToolbarResponse(result: 'Failed');
    }
  }
}

// استفاده در برنامه
void main() async {
  final service = ToolBarDataService(
    client: http.Client(),
    baseUrl: 'https://your-api-url.com',
  );

  final request = ToolbarRequest();
  final response = await service.get(request);

  if (response != null && response.result == 'Success') {
    // پردازش پاسخ موفق
  }
}
