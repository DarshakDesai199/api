import 'package:api/Api%20Get%20through%20Getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiGetX extends StatefulWidget {
  const ApiGetX({Key? key}) : super(key: key);

  @override
  State<ApiGetX> createState() => _ApiGetXState();
}

class _ApiGetXState extends State<ApiGetX> {
  PokeMonController pokeMonController = Get.put(PokeMonController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () {
          if (pokeMonController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
                itemCount: pokeMonController.pokeList?.pokemon?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemBuilder: (BuildContext context, int index) {
                  final info = pokeMonController.pokeList!.pokemon![index];
                  return Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("${info.id}"),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Center(
                            child: Container(
                              height: Get.height * 0.13,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("${info.img}"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Center(
                              child: Text(
                            "${info.candy}",
                            style: TextStyle(fontSize: 17),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Center(
                              child: Text(
                            "${info.name}",
                            style: TextStyle(fontSize: 17),
                          )),
                        ]),
                  );
                });
          }
        },
      ),
    );
  }
}
