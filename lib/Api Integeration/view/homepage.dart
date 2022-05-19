import 'package:api/Api%20Integeration/view/product_detail_screen.dart';
import 'package:flutter/material.dart';

import '../api_services/get_products.dart';
import '../model/product_model.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetProducts.getProductsData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final productInfo = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                  title: productInfo.title,
                                  price: productInfo.price,
                                  description: productInfo.description,
                                  category: productInfo.category,
                                  image: productInfo.image,
                                )));
                  },
                  leading: Hero(
                    tag: "${productInfo.image}",
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${productInfo.image}"),
                    ),
                  ),
                  title: Text("${productInfo.title}"),
                  subtitle: Text("${productInfo.price}"),
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
