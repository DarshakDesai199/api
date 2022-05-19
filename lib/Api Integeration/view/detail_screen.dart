import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final image;
  final title;
  final description;
  final content;
  final url;
  final publishedAt;

  const DetailScreen(
      {Key? key,
      this.image,
      this.title,
      this.description,
      this.content,
      this.url,
      this.publishedAt})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}
// final noimage =
//     "https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg";

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Share.share("${widget.url}");
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "${widget.image}",
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.content,
                    style: TextStyle(color: Colors.grey.shade900, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.publishedAt.toString(),
                    style:
                        TextStyle(color: Colors.green.shade900, fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
