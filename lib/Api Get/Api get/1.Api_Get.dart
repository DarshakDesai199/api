import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '2.Details.dart';

class ApiGet extends StatefulWidget {
  const ApiGet({Key? key}) : super(key: key);

  @override
  State<ApiGet> createState() => _ApiGetState();
}

class _ApiGetState extends State<ApiGet> {
  Future<List> getData() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var result = jsonDecode(response.body);
    print("Response==>${jsonDecode(response.body)}");
    return jsonDecode(response.body);

    /// with out model jsonDecode(response.body) return..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            image: snapshot.data![index]["image"],
                            title: snapshot.data![index]['title'],
                            price: snapshot.data![index]["price"],
                            subtitle: snapshot.data![index]['description'],
                          ),
                        ));
                  },
                  child: ListTile(
                    title: Text("${snapshot.data![index]['title']}"),
                    leading: Hero(
                      tag: snapshot.data![index]['image'],
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${snapshot.data![index]["image"]}"),
                      ),
                    ),
                    subtitle: Text("Price :${snapshot.data![index]["price"]}"),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
