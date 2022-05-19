import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '0.SignUp model.dart';

class ApiPostModel extends StatefulWidget {
  const ApiPostModel({Key? key}) : super(key: key);

  @override
  State<ApiPostModel> createState() => _ApiPostModelState();
}

class _ApiPostModelState extends State<ApiPostModel> {
  Future getData({Map<String, dynamic>? reqBody}) async {
    http.Response response = await http.post(
        Uri.parse("https://codelineinfotech.com/student_api/User/signup.php"),
        body: reqBody);
    var results = jsonDecode(response.body);
    print("Response==>$results");
    return results;
  }

  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _image;

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String?> uploadAvatarWithDio({String? fileName}) async {
    print(fileName);
    dio.FormData formData = new dio.FormData.fromMap({
      "avatar":
          await dio.MultipartFile.fromFile(_image!.path, filename: fileName),
    });

    dio.Response response = await dio.Dio().post(
        "https://codelineinfotech.com/student_api/User/user_avatar_upload.php",
        data: formData);

    print("data ${response.data}");

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

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
              GestureDetector(
                onTap: () {
                  setState(() {
                    getImage();
                  });
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade100),
                  child: _image == null
                      ? Icon(Icons.camera_alt)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String? url = await uploadAvatarWithDio(
                          fileName:
                              "${DateTime.now()}${Random().nextInt(1000)}${_image!.path}");

                      ApiPost _model = ApiPost();
                      _model.firstName = _firstname.text;
                      _model.lastName = _lastname.text;
                      _model.username = _username.text;
                      _model.password = _password.text;
                      _model.avatar = "$url";
                      getData(reqBody: _model.toJson()).then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("successfully SignUp"))));
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
