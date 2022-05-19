import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiSignIn extends StatefulWidget {
  const ApiSignIn({Key? key}) : super(key: key);

  @override
  State<ApiSignIn> createState() => _ApiSignInState();
}

class _ApiSignInState extends State<ApiSignIn> {
  Future getData({String? username, String? password}) async {
    Map<String, dynamic> reqBody = {"username": username, "password": password};
    http.Response response = await http.post(
        Uri.parse("https://codelineinfotech.com/student_api/User/login.php"),
        body: reqBody);
    var results = jsonDecode(response.body);
    print("Response==>$results");
    return results;
  }

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Model"),
        centerTitle: true,
      ),
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
                      getData(
                              username: _username.text,
                              password: _password.text)
                          .then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Successfully LogIn"),
                          ),
                        ),
                      );
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
