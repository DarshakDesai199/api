import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpproRepo {
  static Future SignUpproUser({Map<String, dynamic>? requestBody}) async {
    http.Response responsepro = await http.post(
      Uri.parse(
        "https://codelineinfotech.com/student_api/User/signup.php",
      ),
      body: requestBody,
    );

    var resultpro = jsonDecode(responsepro.body);
    print("Signuppro =========>>>${jsonDecode(responsepro.body)}");
    return resultpro;
  }
}
