import 'dart:convert';

import 'package:api/Headers/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUsers extends StatefulWidget {
  const CreateUsers({Key? key}) : super(key: key);

  @override
  State<CreateUsers> createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {
  Future users(Map<String, dynamic> reqBody) async {
    Map<String, String> headers = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": 'frontend-client',
      " User-ID": "1",
      "Auth-Key": 'simplerestapi',
      "Content-Type": 'application/x-www-form-urlencoded'
    };

    http.Response response = await http.post(
        Uri.parse(
            "http://scprojects.in.net/projects/skoolmonk/api_/user/create"),
        body: reqBody,
        headers: headers);
    var results = jsonDecode(response.body);
    print("Response==> $results");
    if (response.statusCode == 200) {
      return results;
    } else {
      return null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _dob = TextEditingController();
  final _password = TextEditingController();
  final _con = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _fname,
                decoration: InputDecoration(hintText: "FirstName"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _lname,
                decoration: InputDecoration(
                    hintText: "LastName"
                        ""),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _email,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _mobile,
                decoration: InputDecoration(hintText: "Mobile No."),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _dob,
                decoration: InputDecoration(hintText: "DOB"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _password,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                },
                controller: _con,
                decoration: InputDecoration(hintText: "Confirm Password"),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserModel _model = UserModel();
                      _model.fname = _fname.text;
                      _model.lname = _lname.text;
                      _model.email = _email.text;
                      _model.mobile = _mobile.text;
                      _model.dob = _dob.text;
                      _model.password = _password.text;
                      _model.confirmPassword = _con.text;
                      _model.clientKey = "1595922666X5f1fd8bb5f662";
                      _model.deviceType = "MOB";

                      users(_model.toJson()).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("SignUp"),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("SignIn"))
            ],
          ),
        ),
      ),
    );
  }
}
