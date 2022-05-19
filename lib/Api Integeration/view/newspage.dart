import 'package:flutter/material.dart';

import '../api_services/get_products.dart';
import '../model/NewsModel.dart';
import 'detail_screen.dart';

class NewsPages extends StatelessWidget {
  const NewsPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noimage =
        "https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg";
    return Scaffold(
      body: FutureBuilder(
        future: GetNews.getNewsData(),
        builder: (BuildContext context, AsyncSnapshot<NewsModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (BuildContext context, int index) {
                final newsInfo = snapshot.data!.articles![index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              image: newsInfo.urlToImage != null
                                  ? newsInfo.urlToImage
                                  : "$noimage",
                              title: newsInfo.title,
                              description: newsInfo.description,
                              content: newsInfo.content,
                              url: newsInfo.url,
                              publishedAt: newsInfo.publishedAt),
                        ));
                  },
                  leading: Hero(
                    tag: "${newsInfo.urlToImage}",
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${newsInfo.urlToImage}"),
                    ),
                  ),
                  title: Text("${newsInfo.title}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${newsInfo.author}"),
                      Text("${newsInfo.publishedAt}"),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
