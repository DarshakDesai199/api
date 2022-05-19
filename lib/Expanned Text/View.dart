import 'dart:convert';

import 'package:api/Api%20Integeration/model/NewsModel.dart';
import 'package:api/Expanned%20Text/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  bool _enabled = true;

  Future<NewsModel> getNews() async {
    http.Response response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4dd344aa325a41f292b7f0fd159e32f1"));
    // var result = jsonDecode(response.body);
    print("Response==> ${jsonDecode(response.body)}");
    return newsModelFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                var info = snapshot.data!.articles![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsNew(
                                title: info.title,
                                image: info.urlToImage,
                                content: info.content,
                                description: info.description,
                                author: info.author,
                                url: info.url),
                          ));
                    },
                    child: ListTile(
                      leading: Hero(
                        tag: "${info.urlToImage}",
                        child: info.urlToImage != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "${info.urlToImage}",
                                ))
                            : CircularProgressIndicator(color: Colors.red),
                      ),
                      title: Text(
                        "${info.title}",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "${info.content}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: _enabled,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 20,
                            width: 280,
                            color: Colors.grey.shade100,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 20,
                            width: 280,
                            color: Colors.grey.shade100,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                itemCount: 20,
              ),
            );
          }
        },
      ),
    );
  }
}
