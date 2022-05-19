import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '0.product_model.dart';

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  Future<List<PoductModel>> getProductData() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    print('Response==>>${jsonDecode(response.body)}');
    return poductModelFromJson(response.body);

    /// with model in  model from json return.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductData(),
        builder: (context, AsyncSnapshot<List<PoductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage("${snapshot.data![index].image}"),
                    ),
                    title: Text("${snapshot.data![index].title}"),
                    subtitle: Text("Price : ${snapshot.data![index].price}"),
                  ),
                );
              },
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
