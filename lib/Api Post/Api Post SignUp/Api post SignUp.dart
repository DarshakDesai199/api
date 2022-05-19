import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPostSignUp extends StatefulWidget {
  const ApiPostSignUp({Key? key}) : super(key: key);

  @override
  State<ApiPostSignUp> createState() => _ApiPostSignUpState();
}

Future signIRepo(
    {String? firstname,
    String? lastname,
    String? username,
    String? password}) async {
  Map<String, dynamic> reqBody = {
    "first_name": firstname,
    "last_name": lastname,
    "username": username,
    "password": password,
    "avatar":
        "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-confident-1714666150"
  };
  http.Response response = await http.post(
      Uri.parse("https://codelineinfotech.com/student_api/User/signup.php"),
      body: reqBody);
  var result = jsonDecode(response.body);
  print("Response==>$result");
  return result;
}

class _ApiPostSignUpState extends State<ApiPostSignUp> {
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _firstname,
                decoration: InputDecoration(hintText: "firstname"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _lastname,
                decoration: InputDecoration(hintText: "lastname"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _username,
                decoration: InputDecoration(hintText: "username"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _password,
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signIRepo(
                              firstname: _firstname.text,
                              password: _password.text,
                              lastname: _lastname.text,
                              username: _username.text)
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: Text("successfully SignUp"))));
                    }
                  },
                  child: Text("SignUp"))
            ],
          ),
        ),
      ),
    );
  }
}
