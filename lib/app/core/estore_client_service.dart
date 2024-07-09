import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'string_const.dart';

class EstoreServerClient {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int _timeout = 180;

  /// Get request

  static Future<List> get(String url) async {
    String? token = await _storage.read(key: StringConst.eStoreToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Accept": "application/json",
      'authorization': 'Bearer $token',
      "appKey": "65f7d05df174e1715a51900f"
    };
    log('message');
    log("token is $token");

    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log('message ${response.body}');
      return _response(response);
    } on SocketException {
      log('aaaaaaaaaaaaaaaaaaaaaaa');
      return [600, "No internet"];
    } catch (e) {
      log(e.toString());
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    String? token = await _storage.read(key: StringConst.eStoreToken);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": "Bearer $token",
      "appKey": "65f7d05df174e1715a51900f"
    };
    try {
      var body = json.encode(data);
      log(body);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log(response.statusCode.toString());
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  static Future<List> tokenPost(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    try {
      var body = json.encode(data);
      log(body);
      var response = await http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log(response.statusCode.toString());
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    Map<String, dynamic>? data,
    bool put = false,
  }) async {
    String? token = await _storage.read(key: StringConst.eStoreToken);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Accept": "application/json",
      "authorization": "Bearer $token",
      "appKey": "65f7d05df174e1715a51900f"
    };
    try {
      String? body = json.encode(data);
      var response = await http
          .put(Uri.parse(url), body: put ? null : body, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  static Future<List> putWithoutBody(
    String url, {
    Map<String, dynamic>? data,
    bool put = false,
  }) async {
    String? token = await _storage.read(key: StringConst.eStoreToken);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Accept": "application/json",
      "authorization": "Bearer $token", "appKey": "65f7d05df174e1715a51900f"
    };
    try {
      var response = await http
          .put(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(String url, {String? id}) async {
    String? token = await _storage.read(key: StringConst.eStoreToken);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": "Bearer $token",
    };
    var response = await http.delete(Uri.parse(url), headers: headers);
    return await _response(response);
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, "You're using unregistered application"];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"}
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
