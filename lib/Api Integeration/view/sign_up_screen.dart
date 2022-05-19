import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api_services/sign_up_repo.dart';
import '../model/sign_up_model.dart';
import 'homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _userName = TextEditingController();
  final _passWord = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _image;

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future uploadImage({String? fileName}) async {
    dio.FormData formData = await dio.FormData.fromMap({
      "avatar":
          await dio.MultipartFile.fromFile(_image!.path, filename: fileName),
    });
    dio.Response response = await dio.Dio().post(
        "https://codelineinfotech.com/student_api/User/user_avatar_upload.php",
        data: formData);

    if (response.data != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signup',
                    textScaleFactor: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey,
                      child: _image == null
                          ? Icon(Icons.camera)
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _firstName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First name can not be empty";
                      }
                    },
                    decoration: const InputDecoration(hintText: "First Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _lastName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last name can not be empty";
                      }
                    },
                    decoration: const InputDecoration(hintText: "Last Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _userName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "User name can not be empty";
                      }
                    },
                    decoration: const InputDecoration(hintText: "User Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passWord,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password can not be empty";
                      }
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String url = await uploadImage(
                            fileName:
                                "${Random().nextInt(1000)}${_image!.path.toString()}");
                        SignUpModel model = SignUpModel();
                        model.firstName = _firstName.text;
                        model.lastName = _lastName.text;
                        model.username = _userName.text;
                        model.password = _passWord.text;
                        model.avatar = url;

                        SignUpRepo.signUpUser(reqBody: model.toJson()).then(
                          (value) => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                const SnackBar(
                                  content: Text("registered done !"),
                                ),
                              )
                              .closed
                              .then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ),
                                ),
                              ),
                        );
                      }
                    },
                    child: const Text("Sign Up"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
