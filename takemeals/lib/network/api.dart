import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Network {
  // ganti ip sesuai dengan ip komputer
  final Uri _url =
      Uri.parse('https://3bf9-149-108-19-131.ngrok-free.app/api/v1/');

  String? _token;

  Future<void> _getToken() async {
    final storage = FlutterSecureStorage();
    var tokenJson = await storage.read(key: 'token') ?? '';

    if (tokenJson.isNotEmpty) {
      try {
        Map<String, dynamic> token = jsonDecode(tokenJson);

        if (token.containsKey('token')) {
          _token = token['token'];
        }
      } catch (e) {
        // Handle JSON decoding errors
        print("Error decoding JSON: $e");
      }
    }
  }

  Future<http.Response> auth(data, apiURL) async {
    try {
      await _getToken();
      return http.post(
        _url.resolve(apiURL),
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (e) {
      print("Error making POST request: $e");

      return http.Response(
        '{"message": "Error making POST request: $e"}',
        500,
      );
    }
  }

  Future<http.Response> getData(apiURL) async {
    try {
      await _getToken();
      return http.get(
        _url.resolve(apiURL),
        headers: _setHeaders(),
      );
    } catch (e) {
      print("Error making GET request: $e");

      return http.Response(
        '{"message": "Error making GET request: $e"}',
        500,
      );
    }
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
      'ngrok-skip-browser-warning': 'true',
    };
  }
}
