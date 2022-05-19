import 'package:flutter/material.dart';

import '../api_services/sign_up_repo.dart';
import '../model/deleteModel.dart';
import 'homepage.dart';

class DeleteApiScreen extends StatefulWidget {
  const DeleteApiScreen({Key? key}) : super(key: key);

  @override
  _DeleteApiScreenState createState() => _DeleteApiScreenState();
}

class _DeleteApiScreenState extends State<DeleteApiScreen> {
  final _userName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
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
                    'Delete User',
                    textScaleFactor: 2,
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
                    decoration: const InputDecoration(
                        labelText: "UserName", hintText: "Enter User Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        reqdeletemodel model = reqdeletemodel();
                        model.username = _userName.text;

                        DeleteRepo.deleteUser(reqBody: model.toJson())
                            .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                      const SnackBar(
                                        content: Text("User delete done !"),
                                      ),
                                    )
                                    .closed
                                // .then(
                                //   (value) => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => Homepage(),
                                //     ),
                                //   ),
                                // ),
                                );
                      }
                    },
                    child: const Text("Delete"),
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
