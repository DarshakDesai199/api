import 'dart:convert';

import 'package:http/http.dart' as http;

class SignUpRepo {
  static Future signUpUser({Map<String, dynamic>? reqBody}) async {
    http.Response response = await http.post(
      Uri.parse(
        "https://codelineinfotech.com/student_api/User/signup.php",
      ),
      body: reqBody,
    );

    var result = jsonDecode(response.body);
    print("Sign Up Response==>>${jsonDecode(response.body)}");
    return result;
  }
}

class DeleteRepo {
  static Future deleteUser({Map<String, dynamic>? reqBody}) async {
    http.Response response = await http.post(
      Uri.parse(
        "https://codelineinfotech.com/student_api/User/delete_user.php",
      ),
      body: reqBody,
    );
    var result = jsonDecode(response.body);
    print("delete Response==>> ${jsonDecode(response.body)}");
    return result;
  }
}
