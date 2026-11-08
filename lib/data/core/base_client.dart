import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';

abstract class BABaseClient {
  Future<http.Response> post(Uri uri, Map<String, String> body) {
    return http.post(
      uri,
      headers: {
        'Authorization': Secrets.token,
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
  }
}
