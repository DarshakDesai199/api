import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final title;
  final price;
  final description;
  final category;
  final image;

  const ProductDetailScreen(
      {Key? key,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.category,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.price.toString(),
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
