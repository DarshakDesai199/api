import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class StreamApi extends StatefulWidget {
  const StreamApi({Key? key}) : super(key: key);

  @override
  State<StreamApi> createState() => _StreamApiState();
}

class _StreamApiState extends State<StreamApi> {
  StreamController<CurrencyModel> _streamController = StreamController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        getCryptoPrice();
      },
    );
  }

  Future getCryptoPrice() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.nomics.com/v1/currencies/ticker?key=4716237b51c327a56251c27fe176ab59ac6a1d90&ids=BTC"));

    final data = jsonDecode(response.body).first;

    CurrencyModel currencyModel = CurrencyModel.fromJson(data);

    _streamController.sink.add(currencyModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<CurrencyModel> snapshot) {
          var info = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == snapshot.hasError) {
            return Text("Please Wait");
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${info!.name}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  SvgPicture.network("${info.logoUrl}",
                      height: 250, width: 250),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "\$ ${info.price}",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${info.priceTimestamp}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${info.circulatingSupply}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${info.priceDate}")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
