import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '0.model.dart';

class ApiSignIn extends StatefulWidget {
  const ApiSignIn({Key? key}) : super(key: key);

  @override
  State<ApiSignIn> createState() => _ApiSignInState();
}

class _ApiSignInState extends State<ApiSignIn> {
  Future getData(Map<String, dynamic> reqBody) async {
    http.Response response = await http.post(
        Uri.parse("https://codelineinfotech.com/student_api/User/login.php"),
        body: reqBody);
    var result = jsonDecode(response.body);
    print("Response ==> $result");
    if (response.statusCode == 200) {
      return result;
    } else {
      return null;
    }
  }

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                decoration: InputDecoration(hintText: "Username"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignInRepo _model = SignInRepo();
                      _model.username = _username.text;
                      _model.password = _password.text;

                      getData(_model.toJson()).then((value) =>
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("LogIn"))));
                    }
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
