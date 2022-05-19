import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsNew extends StatefulWidget {
  final String? image;
  final String? title;
  final String? content;
  final String? description;
  final String? url;
  final String? author;

  const DetailsNew({
    Key? key,
    this.image,
    this.title,
    this.content,
    this.description,
    this.url,
    this.author,
  }) : super(key: key);

  @override
  State<DetailsNew> createState() => _DetailsNewState();
}

class _DetailsNewState extends State<DetailsNew> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Hero(
                  tag: "${widget.image}",
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${widget.image}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "${widget.title}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Author : ${widget.author}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                ExpandableText(
                  "Content : ${widget.content}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 2,
                  linkColor: Colors.green,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                ExpandableText(
                  "Description : ${widget.description}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 2,
                  linkColor: Colors.green,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _launchInBrowser(Uri.parse("${widget.url}"));
                  },
                  child: Text(
                    "${widget.url}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
