import 'package:http/http.dart' as http;

import 'model.dart';

class ApiServices {
  static Future<Pokemon?> getData() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"),
    );
    if (response.statusCode == 200) {
      return pokemonFromJson(response.body);
    }
    return null;
  }
}
