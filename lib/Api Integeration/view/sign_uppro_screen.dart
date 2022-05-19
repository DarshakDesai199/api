import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api_services/sign_uppro_repo.dart';
import '../model/sign_uppro_model.dart';
import 'newspage.dart';

class SignUpproScreen extends StatefulWidget {
  const SignUpproScreen({Key? key}) : super(key: key);

  @override
  _SignUpproScreenState createState() => _SignUpproScreenState();
}

class _SignUpproScreenState extends State<SignUpproScreen> {
  final _firstname1 = TextEditingController();
  final _lastname1 = TextEditingController();
  final _username1 = TextEditingController();
  final _password1 = TextEditingController();

  final _formkey1 = GlobalKey<FormState>();
  final picker1 = ImagePicker();
  File? _image1;

  Future pickImageFromGallerypro() async {
    final pickedFilepro = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFilepro != null) {
      setState(() {
        _image1 = File(pickedFilepro.path);
      });
    }
  }

  Future uploadImagepro({String? fileName}) async {
    dio.FormData formData1 = dio.FormData.fromMap({
      "avatar":
          await dio.MultipartFile.fromFile(_image1!.path, filename: fileName),
    });
    dio.Response response = await dio.Dio().post(
        "https://codelineinfotech.com/student_api/User/user_avatar_upload.php",
        data: formData1);

    if (response.data != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromGallerypro();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: _image1 == null
                        ? Icon(Icons.camera)
                        : Image.file(
                            _image1!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _firstname1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter First name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "enter first name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _lastname1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter last name";
                    }
                  },
                  decoration: InputDecoration(hintText: "enter last name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _username1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter user name";
                    }
                  },
                  decoration: InputDecoration(hintText: "enter user name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _password1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter password";
                    }
                  },
                  decoration: InputDecoration(hintText: "enter pssword"),
                ),
                SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate()) {
                      String url = await uploadImagepro(
                          fileName:
                              "${Random().nextInt(1000)}${_image1!.path.toString()}");
                      SignUpproModel model1 = SignUpproModel();
                      model1.firstName = _firstname1.text;
                      model1.lastName = _lastname1.text;
                      model1.username = _username1.text;
                      model1.password = _password1.text;
                      model1.avatar = url;

                      SignUpproRepo.SignUpproUser(requestBody: model1.toJson())
                          .then(
                        (value) => ScaffoldMessenger.of(context)
                            .showSnackBar(
                              const SnackBar(
                                content: Text("news registered done !"),
                              ),
                            )
                            .closed
                            .then(
                              (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsPages(),
                                ),
                              ),
                            ),
                      );
                    }
                  },
                  child: Text("Create A/C"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
