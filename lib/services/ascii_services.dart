import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ascii_image/constants/error_handling.dart';
import 'package:ascii_image/constants/utils.dart';

class AsciiServices {
  String ansi = "";

  Future<String> getAnsiValue(String text) async {
    http.Response response = await http.get(
      Uri.parse('$uri/$text'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      ansi = responseJson['ansi'];
      print(ansi);
    } else {
      throw Exception('Failed to load ansi value');
    }
    return ansi;
  }

  Future<String> uploadTextCommand({
    required String text,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/$text'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final responseJson = jsonDecode(res.body);
          ansi = responseJson['ansi'];
          print(ansi);
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return ansi;
  }

  Future<String> uploadImageCommand({
    required String url,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/file'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "url": url,
        }),
      );
      print("check3");
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final responseJson = jsonDecode(res.body);
          ansi = responseJson['ansi'];
          print(ansi);
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return ansi;
  }
}
