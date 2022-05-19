import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final image;
  final title;
  final price;
  final subtitle;

  const Details({Key? key, this.image, this.title, this.price, this.subtitle})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Hero(
                tag: widget.image,
                child: Container(
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("${widget.image}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "${widget.title}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Price : ${widget.price}",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Description : ${widget.subtitle}",
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
